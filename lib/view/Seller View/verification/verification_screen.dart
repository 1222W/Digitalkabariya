import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_kabaria_app/common/custom_button.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/app_text.dart';
import 'package:digital_kabaria_app/utils/custom_navigation.dart';
import 'package:digital_kabaria_app/utils/firebase_data.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:digital_kabaria_app/view/Seller%20View/Auth%20View/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/sign_up/sign_up_controller.dart';

class VerfificationScreen extends StatefulWidget {
  const VerfificationScreen({super.key});

  @override
  State<VerfificationScreen> createState() => _RequestApprovalScreenState();
}

class _RequestApprovalScreenState extends State<VerfificationScreen> {
  final controller = Get.put(SignUpController());
  User? user;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    user?.reload();
    checkApproval();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      checkApproval();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  checkApproval() async {
    user = FirebaseAuth.instance.currentUser;
    await user?.reload();
    final userEmailVerified = user?.emailVerified ?? false;

    if (userEmailVerified) {
      final id = user?.uid;
      if (id != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection(Collection.user)
            .doc(id)
            .get();
        final role = userDoc.data()?['role'];
        pushReplacement(context, const LoginView());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppText(
                text: "Verification Pending...",
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: AppColors.appColor,
              ),
              const AppText(
                textAlign: TextAlign.center,
                text:
                    "Email verification pending. Please verify your email and resend the email.",
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
              10.h.sizedBoxHeight,
              CustomButton(
                btnWidth: 150,
                text: "Resend Email",
                onPressed: () {
                  controller.sendEmailVerificationLink(context);
                },
              ),
              10.h.sizedBoxHeight,
              InkWell(
                onTap: () {
                  push(context, const LoginView());
                },
                child: const AppText(
                  textAlign: TextAlign.center,
                  textDecoration: TextDecoration.underline,
                  text: "Go to Back",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
