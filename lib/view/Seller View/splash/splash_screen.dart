import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_kabaria_app/model/users.model.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/app_text.dart';
import 'package:digital_kabaria_app/utils/custom_navigation.dart';
import 'package:digital_kabaria_app/utils/enums.dart';
import 'package:digital_kabaria_app/view/Collector%20View/collector_bottom_nav_view.dart';
import 'package:digital_kabaria_app/view/Company%20View/company_bottom_view.dart';
import 'package:digital_kabaria_app/view/Seller%20View/Auth%20View/banned_account_view.dart';
import 'package:digital_kabaria_app/view/Seller%20View/Auth%20View/login_view.dart';
import 'package:digital_kabaria_app/view/Seller%20View/home_view/seller_home_view.dart';
import 'package:digital_kabaria_app/view/Seller%20View/verification/verification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showSecond = false;

  @override
  void initState() {
    super.initState();
    _toggleFade();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUser(context);
    });
  }

  void _toggleFade() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showSecond = !_showSecond;
        });
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            checkUser(context);
          }
        });
      }
    });
  }

  checkUser(BuildContext context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      pushUntil(context, const LoginView());
      return;
    }

    if (!currentUser.emailVerified) {
      pushUntil(context, const VerfificationScreen());
      return;
    }

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    if (userDoc.exists) {
      var userData = userDoc.data() as Map<String, dynamic>;

      UsersModel userModel = UsersModel.fromJson(userData);

      if (userModel.isVerify!) {
        if (userModel.isBlock!) {
          pushReplacement(context, const BannedAccountView());
        } else if (userModel.role == ROLENAME.Seller.name) {
          pushReplacement(context, SellerHomeView(userModel: userModel));
        } else if (userModel.role == ROLENAME.Collector.name) {
          pushReplacement(context, CollectorBottomNavBar(userModel: userModel));
        } else if (userModel.role == ROLENAME.Buyer.name) {
          pushReplacement(context, CompanyBottomBar(userModel: userModel));
        }
      } else {
        pushUntil(context, const LoginView());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: AnimatedCrossFade(
          firstChild: Image.asset(
            "assets/images/app_logo_dk.png",
            height: 200,
            width: 200,
          ),
          secondChild: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/app_logo_dk.png",
                height: 30,
                width: 30,
              ),
              const AppText(
                text: " Digital Kabariya",
                fontSize: 30,
              ),
            ],
          ),
          crossFadeState: _showSecond
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(seconds: 2),
        ),
      ),
    );
  }
}
