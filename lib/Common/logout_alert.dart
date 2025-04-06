import 'package:digital_kabaria_app/Utils/custom_navigation.dart';
import 'package:digital_kabaria_app/common/custom_button.dart';
import 'package:digital_kabaria_app/common/custom_text_form_field.dart';
import 'package:digital_kabaria_app/preferences/pref.dart';
import 'package:digital_kabaria_app/view/Admin%20Side%20View/admin_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

showLogoutDialog(context) {
  return showDialog(
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
                  'Are you sure you want to sign out?',
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
            
              Center(
                  child: CustomButton(
                text: "Yes",
                onPressed: () {
                  Pref.clearPref();
                  pushUntil(context, const AdminLoginScreen());
                },
              )),
              SizedBox(
                height: 10.h,
              ),
              Center(
                  child: CustomButton(
                    btnColor: AppColors.whiteColor,
                    textColor: AppColors.appColor,
                    border: const BorderSide(color: AppColors.appColor),
                text: "No",
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
            ],
          ),
        ),
      );
    },
  );
}
