import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyFavoriteListWidget extends StatelessWidget {
  const EmptyFavoriteListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "AppTextEnglish.emptyFavoriteList.tr",
            style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
          5.h.sizedBoxHeight,
          Text(
            "Hello",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.blackColor.withOpacity(.50),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500),
          ),
          10.h.sizedBoxHeight,
        ],
      ),
    );
  }
}
