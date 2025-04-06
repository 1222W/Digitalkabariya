import 'package:digital_kabaria_app/common/app_loader.dart';
import 'package:digital_kabaria_app/common/custom_app_bar.dart';
import 'package:digital_kabaria_app/common/custom_button.dart';
import 'package:digital_kabaria_app/common/custom_drop_down.dart';
import 'package:digital_kabaria_app/common/custom_text_form_field.dart';
import 'package:digital_kabaria_app/controllers/sign_up/sign_up_controller.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/enums.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:digital_kabaria_app/view/Seller%20View/verification/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          // flag: true,
          ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.h.sizedBoxHeight,
                Text(
                  "Welcome! Create your\naccount".tr,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                20.h.sizedBoxHeight,
                Obx(() => CustomTextFormField(
                      controller: controller.fullNameCTRL,
                      hintText: "Full Name".tr,
                      flag: true,
                      onChanged: controller.validateFullName,
                      errorText: controller.fullNameError.value,
                    )),
                10.h.sizedBoxHeight,
                Obx(() => CustomTextFormField(
                      controller: controller.emailCTRL,
                      hintText: "Email Address".tr,
                      flag: true,
                      onChanged: controller.validateEmail,
                      errorText: controller.emailError.value,
                    )),
                10.h.sizedBoxHeight,
                Obx(() => CustomTextFormField(
                      controller: controller.phoneCTRL,
                      hintText: "Phone No".tr,
                      flag: true,
                      keyboardType: TextInputType.number,
                      onChanged: controller.validatePhone,
                      errorText: controller.phoneError.value,
                    )),
                10.h.sizedBoxHeight,
                Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomDropDown(
                          dropdownItems: [
                            ROLENAME.Seller.name,
                            ROLENAME.Collector.name,
                            ROLENAME.Buyer.name
                          ],
                          selectedItem: controller.selectedDropdownItem.value ??
                              "Sign Up As!".tr,
                          isDropdownOpen: false,
                          onChanged: (value) {
                            controller.selectedDropdownItem.value = value;
                            controller.validateDropdown(value);
                          },
                        ),
                        if (controller.dropdownError.value != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              controller.dropdownError.value!,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                      ],
                    )),
                10.h.sizedBoxHeight,
                Obx(() => CustomTextFormField(
                      controller: controller.passwordCTRL.value,
                      hintText: "Set Password".tr,
                      flag: true,
                      obscureText: controller.obsecurePassword.value,
                      onChanged: controller.validatePassword,
                      errorText: controller.passwordError.value,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.togglePassword();
                        },
                        icon: Icon(
                          controller.obsecurePassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 20.sp,
                          color: controller.obsecurePassword.value
                              ? AppColors.blackColor.withOpacity(.30)
                              : AppColors.appColor,
                        ),
                      ),
                    )),
                10.h.sizedBoxHeight,
                Obx(() => CustomTextFormField(
                      controller: controller.confirmPasswordCTRL.value,
                      hintText: "Confirm Password".tr,
                      flag: true,
                      obscureText: controller.obsecureConfirmPassword.value,
                      onChanged: controller.validateConfirmPassword,
                      errorText: controller.passwordConfirmError.value,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.toggleConfirmPassword();
                        },
                        icon: Icon(
                          controller.obsecureConfirmPassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 20.sp,
                          color: controller.obsecureConfirmPassword.value
                              ? AppColors.blackColor.withOpacity(.30)
                              : AppColors.appColor,
                        ),
                      ),
                    )),
                14.h.sizedBoxHeight,
                20.h.sizedBoxHeight,
                Obx(
                  () => controller.isLoading.value
                      ? const Center(
                          child: AppLoader(),
                        )
                      : CustomButton(
                          text: "Create Account".tr,
                          onPressed: controller.enableSignUpButton
                              ? () async {
                                  if (controller.selectedDropdownItem.value ==
                                      ROLENAME.Seller.name) {
                                    await controller.signUp(context,
                                        screen: const VerfificationScreen(),
                                        emailAddress: controller.emailCTRL.text,
                                        password:
                                            controller.passwordCTRL.value.text,
                                        fullName: controller.fullNameCTRL.text,
                                        phoneNumber: controller.phoneCTRL.text,
                                        role: controller
                                            .selectedDropdownItem.value
                                            .toString(),
                                        isVerify: true);
                                  } else if (controller
                                          .selectedDropdownItem.value ==
                                      ROLENAME.Collector.name) {
                                    await controller.signUp(context,
                                        screen: const VerfificationScreen(),
                                        emailAddress: controller.emailCTRL.text,
                                        password:
                                            controller.passwordCTRL.value.text,
                                        fullName: controller.fullNameCTRL.text,
                                        phoneNumber: controller.phoneCTRL.text,
                                        role: controller
                                            .selectedDropdownItem.value
                                            .toString(),
                                        isVerify: true);
                                  } else if (controller
                                          .selectedDropdownItem.value ==
                                      ROLENAME.Buyer.name) {
                                    await controller.signUp(context,
                                        screen: const VerfificationScreen(),
                                        emailAddress: controller.emailCTRL.text,
                                        password:
                                            controller.passwordCTRL.value.text,
                                        fullName: controller.fullNameCTRL.text,
                                        phoneNumber: controller.phoneCTRL.text,
                                        role: controller
                                            .selectedDropdownItem.value
                                            .toString(),
                                        isVerify: false);
                                  }
                                }
                              : null
                          ),
                ),
                10.h.sizedBoxHeight,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Already Registered?".tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.blackColor.withOpacity(.5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    5.w.sizedBoxWidth,
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.appColor,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.appColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                20.h.sizedBoxHeight,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
