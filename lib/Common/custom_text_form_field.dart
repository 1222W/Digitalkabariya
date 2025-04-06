// ignore_for_file: library_private_types_in_public_api

import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool flag;
  final bool obscureText;
  final int maxLines;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final controller;
  final String? errorText;
  final bool readOnly;
  const CustomTextFormField(
      {Key? key,
      this.hintText,
      this.hintStyle,
      this.suffixIcon,
      this.readOnly = false,
      this.prefixIcon,
      this.controller = "",
      this.keyboardType,
      this.flag = false,
      this.obscureText = false,
      this.onChanged,
      this.validator,
      this.errorText,
      this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      cursorColor: AppColors.blackColor.withOpacity(.75),
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        errorText: errorText,
        hintText: hintText ?? 'HintText',
        labelText: flag ? hintText : null,
        fillColor: AppColors.whiteColor,
        filled: true,
        errorMaxLines: 1,
        constraints: BoxConstraints(
            minWidth: double.infinity.h,
            minHeight: 45.h,
            maxHeight: double.infinity),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
        errorStyle: TextStyle(
            fontSize: 12.sp,
            color: AppColors.redColor,
            fontWeight: FontWeight.w500),
        labelStyle: TextStyle(
            fontSize: 14.sp,
            color: AppColors.appColor,
            fontWeight: FontWeight.w500),
        hintStyle: hintStyle ??
            TextStyle(
                fontSize: 14.sp,
                color: AppColors.blackColor.withOpacity(.50),
                fontWeight: FontWeight.w500),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: BorderSide(
              color: AppColors.blackColor.withOpacity(.25),
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: const BorderSide(
              color: AppColors.appColor,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: const BorderSide(
              color: AppColors.appColor,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: const BorderSide(
              color: AppColors.redColor,
            )),
      ),
    );
  }
}
