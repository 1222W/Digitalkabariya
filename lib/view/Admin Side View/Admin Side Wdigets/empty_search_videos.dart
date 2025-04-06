import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptySearchVideosWidget extends StatelessWidget {
  const EmptySearchVideosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "",
            style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
          10.h.sizedBoxHeight,
        ],
      ),
    );
  }
}
