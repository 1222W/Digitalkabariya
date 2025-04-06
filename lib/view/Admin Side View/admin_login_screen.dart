import 'package:digital_kabaria_app/Common/app_loader.dart';
import 'package:digital_kabaria_app/Utils/app_colors.dart';
import 'package:digital_kabaria_app/Utils/app_text.dart';
import 'package:digital_kabaria_app/Utils/custom_navigation.dart';
import 'package:digital_kabaria_app/Utils/preferences.dart';
import 'package:digital_kabaria_app/Utils/utils.dart';
import 'package:digital_kabaria_app/preferences/pref.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:digital_kabaria_app/view/Admin%20Side%20View/admin_side_view.dart';
import 'package:digital_kabaria_app/view/Admin%20Side%20View/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../../Common/custom_button.dart';
import '../../Common/custom_text_form_field.dart';
import '../Seller View/Auth View/Auth State/auth_state.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final authState = Get.put(AuthStateController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.appColor,
      body: Center(
        child: Container(
          height: size.height * .70,
          width: size.width * .40,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Image.asset(
                    "assets/images/app_logo_dk.png",
                    height: 75.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const AppText(
                    text: "Digital Kabaria",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Email".tr,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  10.h.sizedBoxHeight,
                  // Email
                  Obx(() => CustomTextFormField(
                        controller: authState.emailCTRL,
                        hintText: "Email Address",
                        flag: true,
                        onChanged: authState.validateEmail,
                        errorText: authState.emailError.value,
                      )),
                  20.h.sizedBoxHeight,
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Password".tr,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  10.h.sizedBoxHeight,
                  // Password
                  Obx(() => CustomTextFormField(
                        controller: authState.passwordCTRL,
                        hintText: "Password",
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
                  20.h.sizedBoxHeight,

                  Obx(() {
                    return authState.isLoading.value
                        ? const AppLoader()
                        : CustomButton(
                            text: "Login".tr,
                            onPressed: authState.enableLoginButton
                                ? () {
                                    if (authState.emailCTRL.value.text !=
                                        "admin@gmail.com") {
                                      Utils.flushBarErrorMessage(
                                          "Please enter valid admin email",
                                          context);
                                    } else if (authState
                                            .passwordCTRL.value.text !=
                                        "admin@123") {
                                      Utils.flushBarErrorMessage(
                                          "Please enter valid admin password",
                                          context);
                                    } else if (authState.emailCTRL.value.text ==
                                            "admin@gmail.com" &&
                                        authState.passwordCTRL.value.text ==
                                            "admin@123") {
                                              Pref.setUser("admin@gmail.com");
                                      pushUntil(context, const DashBoardScreen());
                                      Utils.successBar(
                                          "Login SuccessFully!", context);
                                    }
                                  }
                                : null);
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
