import 'dart:developer';
import 'package:digital_kabaria_app/common/app_loader.dart';
import 'package:digital_kabaria_app/common/custom_app_bar.dart';
import 'package:digital_kabaria_app/common/custom_button.dart';
import 'package:digital_kabaria_app/common/custom_text_form_field.dart';
import 'package:digital_kabaria_app/controllers/sign_up/reset_password_controller.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/custom_navigation.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:digital_kabaria_app/utils/utils.dart';
import 'package:digital_kabaria_app/view/Admin%20Side%20View/admin_side_view.dart';
import 'package:digital_kabaria_app/view/Seller%20View/Auth%20View/Auth%20State/auth_state.dart';
import 'package:digital_kabaria_app/view/Seller%20View/Auth%20View/banned_account_view.dart';
import 'package:digital_kabaria_app/view/Seller%20View/Auth%20View/sign_up_view.dart';
import 'package:digital_kabaria_app/view/Seller%20View/user_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:page_transition/page_transition.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

var emailValidation =
    RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');

class _LoginViewState extends State<LoginView> {
  final authState = Get.put(AuthStateController());
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    authState.emailCTRL.clear();
    authState.passwordCTRL.clear();
    authState.rememberMe.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: false,
      progressIndicator: const AppLoader(),
      blur: 2,
      child: Scaffold(
        appBar: const CustomAppBar(
          flag: false,
        ),
        body: Form(
          autovalidateMode: AutovalidateMode.always,
          child: ListView(
            padding: EdgeInsets.all(20.sp),
            physics: const BouncingScrollPhysics(),
            children: [
              Center(
                child: Text(
                  "Welcome Back! Access your account".tr,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              30.h.sizedBoxHeight,
              //
              Text(
                "Email".tr,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              10.h.sizedBoxHeight,

              Obx(() => CustomTextFormField(
                    controller: authState.emailCTRL,
                    hintText: "Email Address".tr,
                    flag: true,
                    onChanged: authState.validateEmail,
                    errorText: authState.emailError.value,
                  )),
              20.h.sizedBoxHeight,
              Text(
                "Password".tr,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              10.h.sizedBoxHeight,
              // Password
              Obx(() => CustomTextFormField(
                    controller: authState.passwordCTRL,
                    hintText: "Password".tr,
                    flag: true,
                    obscureText: authState.obsecurePassword,
                    onChanged: authState.validatePassword,
                    errorText: authState.passwordError.value,
                    suffixIcon: IconButton(
                      onPressed: () {
                        authState.togglePassword();
                      },
                      icon: Icon(
                        authState.obsecurePassword
                            ? Icons.visibility_off
                            : Icons.visibility_outlined,
                        size: 20.sp,
                        color: authState.obsecurePassword
                            ? AppColors.blackColor.withOpacity(.30)
                            : AppColors.appColor,
                      ),
                    ),
                  )),

              //

              30.h.sizedBoxHeight,
              //
              Center(
                child: InkWell(
                  onTap: () {
                    authState.autoValidate.value = false;

                    resetPasswordDialogue(context);
                  },
                  child: Text(
                    "Reset Password?".tr,
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.appColor,
                        fontWeight: FontWeight.w500,
                        decorationColor: AppColors.appColor,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
              20.h.sizedBoxHeight,
              //
              Obx(() {
                return authState.isLoading.value
                    ? const AppLoader()
                    : CustomButton(
                        text: "Login".tr,
                        onPressed: authState.enableLoginButton
                            ? () {
                                authState.login(
                                  context,
                                  emailAddress: authState.emailCTRL.value.text,
                                  password: authState.passwordCTRL.value.text,
                                );
                              }
                            : null);
              }),
              //
              20.h.sizedBoxHeight,

              CustomButton(
                text: "Create Account".tr,
                textColor: AppColors.appColor,
                btnColor: AppColors.whiteColor,
                border: const BorderSide(color: AppColors.appColor),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: const SignUpView(),
                          type: PageTransitionType.fade));
                },
              ),

              10.h.sizedBoxHeight,
            ],
          ),
        ),
      ),
    );
  }
}

void resetPasswordDialogue(
  BuildContext context,
) {
  TextEditingController emailController = TextEditingController();
  final resetState = Get.put(ResetPasswordController());

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 40.h),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Reset Password!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Enter Email:',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.blackColor.withOpacity(.50),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              // DATE PICKER

              CustomTextFormField(
                controller: emailController,
                hintText: "Enter Email Address",
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(
                height: 15.h,
              ),
              Center(
                child: Obx(() {
                  return resetState.isLoading.value
                      ? const AppLoader()
                      : CustomButton(
                          text: "Continue",
                          onPressed: () {
                            resetState.resetPassword(context,
                                email: emailController.text);
                          },
                        );
                }),
              )
            ],
          ),
        ),
      );
    },
  );
}
