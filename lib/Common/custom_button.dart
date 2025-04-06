import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final Color? btnColor;
  final double? btnHeight;
  final double? textSize;
  final double? btnWidth;
  final BorderSide? border;
  final Widget? child;
  final Function()? onPressed;
  const CustomButton(
      {super.key,
      this.text,
      this.textColor,
      this.btnColor,
      this.onPressed,
      this.btnHeight,
      this.btnWidth,
      this.border,
      this.textSize,
      this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: btnHeight ?? 45.h,
      width: btnWidth ?? double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              maximumSize: Size(double.infinity, 50.h),
              minimumSize: Size(double.infinity, 30.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.sp),
                  side: border ?? BorderSide.none),
              backgroundColor: btnColor ?? AppColors.appColor,
              foregroundColor: textColor ?? AppColors.whiteColor,
              disabledBackgroundColor: AppColors.greyColor,
              disabledForegroundColor: AppColors.whiteColor),
          onPressed: onPressed,
          child: child ??
              Text(
                text ?? "text",
                style: TextStyle(
                  fontSize: textSize,
                  color: textColor ?? AppColors.whiteColor,
                ),
              )),
    );
  }
}

// Round Button

class SocialLoginButton extends StatelessWidget {
  final String imageAddress;
  final Color? textColor;
  final Color? btnColor;
  final Widget? child;
  final Function()? onTap;

  const SocialLoginButton(
      {super.key,
      required this.imageAddress,
      this.textColor,
      this.btnColor,
      this.child,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: 50.w,
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: btnColor ?? AppColors.whiteColor,
            border: Border.all(color: AppColors.tealColor)),
        child: child ??
            Image.asset(
              imageAddress,
              fit: BoxFit.cover,
            ),
      ),
    );
  }
}
