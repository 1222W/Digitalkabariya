import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
          backgroundColor: AppColors.appColor,
      radius: 25,
     child: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          strokeWidth: 3.w,
          strokeCap: StrokeCap.round,
          color: AppColors.whiteColor,
        ),
      ),
    )
    );
  }
}
