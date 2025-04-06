import 'package:digital_kabaria_app/common/custom_button.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:digital_kabaria_app/languages_proivder.dart';
import 'package:digital_kabaria_app/view/Seller%20View/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../view/Seller View/User State/user_state.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool flag;
  const CustomAppBar({super.key, this.flag = false});

  @override
  Widget build(BuildContext context) {
    // ---- Variables & States ---------- //
    final userState = Get.put(UserState());
    // ignore: unused_local_variable
    final languageProvider = Get.put(LanguagesProvider());

    List<String> languages = ['English', 'Urdu'];

    return GetBuilder<LanguagesProvider>(builder: (languageProvider) {
      return AppBar(
        leadingWidth: 40.w,
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Image.asset(
            "assets/images/app_logo_dk.png",
            // height: 50.h,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            "Digital Kabariya".tr,
            style: TextStyle(
                color: AppColors.blackColor,
                letterSpacing: 1,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
        actions: flag
            ? []
            : [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    showCupertinoDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Padding(
                              padding: EdgeInsets.all(5.sp),
                              child: Text(
                                "Choose Language!",
                                style: TextStyle(
                                    color: AppColors.blackColor,
                                    letterSpacing: 1,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            content: Column(
                              children: List.generate(
                                  2,
                                  (index) => GestureDetector(
                                        onTap: languageProvider
                                                    .selectedLanguage.value ==
                                                languages[index]
                                            ? null
                                            : () {
                                                languageProvider.updateLanguage(
                                                    languages[index]);
                                                if (languageProvider
                                                        .selectedLanguage
                                                        .value ==
                                                    'English') {
                                                  Get.updateLocale(
                                                      const Locale('en'));
                                                } else {
                                                  Get.updateLocale(
                                                      const Locale('ur'));
                                                }
                                              },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10.sp, vertical: 5.h),
                                          padding: EdgeInsets.all(10.sp),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: languageProvider
                                                          .selectedLanguage
                                                          .value ==
                                                      languages[index]
                                                  ? AppColors.appColor
                                                  : AppColors.blackColor
                                                      .withOpacity(.1),
                                              borderRadius:
                                                  BorderRadius.circular(8.sp)),
                                          child: Text(
                                            languages[index],
                                            style: TextStyle(
                                                color: languageProvider
                                                            .selectedLanguage
                                                            .value ==
                                                        languages[index]
                                                    ? AppColors.whiteColor
                                                    : AppColors.blackColor,
                                                letterSpacing: 1,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      )),
                            ),
                            actions: [
                              Padding(
                                padding: EdgeInsets.all(15.sp),
                                child: CustomButton(
                                  text: 'Close',
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              )
                            ],
                          );
                        });
                  },
                  icon: Container(
                    height: 45.h,
                    width: 75.w,
                    decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(4.sp),
                        color: AppColors.blackColor.withOpacity(.15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.language,
                          color: AppColors.blackColor,
                          size: 20.sp,
                        ),
                        Text(
                          "Language".tr,
                          style: TextStyle(
                              color: AppColors.blackColor,
                              letterSpacing: 1,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                10.w.sizedBoxWidth,
                10.w.sizedBoxWidth
              ],
      );
    });
  }

  @override
  Size get preferredSize => Size(double.infinity, 60.h);
}
