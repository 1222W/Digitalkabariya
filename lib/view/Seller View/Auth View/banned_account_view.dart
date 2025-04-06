import 'package:digital_kabaria_app/Common/logout_alert.dart';
import 'package:digital_kabaria_app/Utils/custom_navigation.dart';
import 'package:digital_kabaria_app/common/custom_app_bar.dart';
import 'package:digital_kabaria_app/common/custom_button.dart';
import 'package:digital_kabaria_app/preferences/pref.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:digital_kabaria_app/view/Seller%20View/Auth%20View/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannedAccountView extends StatefulWidget {
  const BannedAccountView({super.key});

  @override
  State<BannedAccountView> createState() => _BannedAccountViewState();
}

class _BannedAccountViewState extends State<BannedAccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        flag: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20.sp),
        physics: const BouncingScrollPhysics(),
        children: [
          Center(
            child: Text(
              "Account Suspended!",
              style: TextStyle(
                fontSize: 18.sp,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          20.h.sizedBoxHeight,
          Center(
            child: Text(
              "Your account has been suspended due to a violation of our app's terms of service. Contact at admin@gmail.com",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.blackColor.withOpacity(.5),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          50.h.sizedBoxHeight,
          CustomButton(
            text: "Close",
            onPressed: () {
              Pref.clearPref();
              pushReplacement(context, const LoginView());
            },
          )
          //
        ],
      ),
    );
  }
}
