import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_kabaria_app/Utils/preferences.dart';
import 'package:digital_kabaria_app/common/app_toast_message.dart';
import 'package:digital_kabaria_app/model/users.model.dart';
import 'package:digital_kabaria_app/utils/custom_navigation.dart';
import 'package:digital_kabaria_app/utils/firebase_data.dart';
import 'package:digital_kabaria_app/utils/utils.dart';
import 'package:digital_kabaria_app/view/Collector%20View/collector_bottom_nav_view.dart';
import 'package:digital_kabaria_app/view/Company%20View/company_bottom_view.dart';
import 'package:digital_kabaria_app/view/Seller%20View/Auth%20View/banned_account_view.dart';
import 'package:digital_kabaria_app/view/Seller%20View/Auth%20View/login_view.dart';
import 'package:digital_kabaria_app/view/Seller%20View/approval/approval_screen.dart';
import 'package:digital_kabaria_app/view/Seller%20View/home_view/seller_home_view.dart';
import 'package:digital_kabaria_app/view/Seller%20View/user_home_view.dart';
import 'package:digital_kabaria_app/view/Seller%20View/verification/verification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utils/enums.dart';

class AuthStateController extends GetxController {
  final emailCTRL = TextEditingController();
  final passwordCTRL = TextEditingController();
  final recoverEmailCTRL = TextEditingController().obs;
  final isLoading = false.obs;
  void setLoading(value) {
    isLoading.value = value;
  }

  final RxBool _obsecurePassword = true.obs;
  bool get obsecurePassword => _obsecurePassword.value;
  void togglePassword() {
    _obsecurePassword.value = !_obsecurePassword.value;
    update();
  }

  
  final RxBool rememberMe = true.obs;
  void toggleRemeberMe(bool? value) {
    rememberMe.value = value!;
    update();
  }

  final emailError = RxnString(null);
  final passwordError = RxnString(null);

  void validateEmail(String value) {
    if (value.isEmpty || !GetUtils.isEmail(value)) {
      emailError.value = "Please enter a valid email";
    } else {
      emailError.value = null;
    }
    updateLoginButton();
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      passwordError.value = "Please enter a password";
    } else {
      passwordError.value = null;
    }
    updateLoginButton();
  }

  // Enable Login Button
  final RxBool _enableLoginButton = false.obs;
  bool get enableLoginButton => _enableLoginButton.value;
  void updateLoginButton() {
    if (emailCTRL.text.isNotEmpty &&
        passwordCTRL.value.text.isNotEmpty &&
        emailError.value == null &&
        passwordError.value == null) {
      _enableLoginButton.value = true;
    } else {
      _enableLoginButton.value = false;
    }
  }

  final autoValidate = false.obs;

  login(
    context, {
    required String emailAddress,
    required String password,
  }) async {
    updateLoginButton();
    if (enableLoginButton) {
      try {
        setLoading(true);
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailAddress, password: password);

        String id = FirebaseAuth.instance.currentUser!.uid;
        final user = await FirebaseFirestore.instance
            .collection(Collection.user)
            .doc(id)
            .get();
        // debugger();

        UsersModel userModel = UsersModel.fromJson(user.data()!);
        // debugger();
        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          if (userModel.isVerify!) {
            if (userModel.isBlock!) {
              pushReplacement(context, const BannedAccountView());
            } else if (userModel.role == ROLENAME.Seller.name) {
              pushReplacement(context, SellerHomeView(userModel: userModel));
            } else if (userModel.role == ROLENAME.Collector.name) {
              pushReplacement(
                  context, CollectorBottomNavBar(userModel: userModel));
            } else if (userModel.role == ROLENAME.Buyer.name) {
              pushReplacement(context, CompanyBottomBar(userModel: userModel));
            }
          } else {
            pushReplacement(
                context,
                RequestApprovalScreen(
                  usersModel: userModel,
                ));
          }
        } else {
          pushReplacement(context, const VerfificationScreen());
        }

        setLoading(false);
        Utils.successBar("User Sign in SuccessFully!", context);
      } on FirebaseAuthException catch (e) {
        // debugger();

        log(e.toString());
        setLoading(false);
        Utils.flushBarErrorMessage(e.toString(), context);
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
        setLoading(false);
      }
    }
  }

  logOut(context) {
    try {
      setLoading(true);
      FirebaseAuth auth = FirebaseAuth.instance;
      auth.signOut();
      Preferences.clear();
      setLoading(false);
      pushReplacement(context, const LoginView());
      Utils.flushBarErrorMessage("Logout SuccessFully!", context);
    } catch (e) {
      setLoading(false);

      print(e.toString());
    }
  }
}
