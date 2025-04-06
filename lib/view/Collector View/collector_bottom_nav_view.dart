import 'package:digital_kabaria_app/Utils/custom_navigation.dart';
import 'package:digital_kabaria_app/common/custom_app_bar.dart';
import 'package:digital_kabaria_app/controllers/collector_controllers/collector_state_controller.dart';
import 'package:digital_kabaria_app/model/users.model.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:digital_kabaria_app/view/Seller%20View/Auth%20View/banned_account_view.dart';

import 'package:digital_kabaria_app/view/Seller%20View/home_view/home_view.dart';
import 'package:digital_kabaria_app/view/Seller%20View/home_view/seller_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'collector_product_view.dart';

class CollectorBottomNavBar extends StatefulWidget {
  UsersModel? userModel;
  CollectorBottomNavBar({super.key, this.userModel});

  @override
  State<CollectorBottomNavBar> createState() => _CollectorBottomNavBarState();
}

class _CollectorBottomNavBarState extends State<CollectorBottomNavBar> {
  final collectorState = Get.put(CollectorStateController());
  final List<Widget> pages = [
    const HomeView(),
    const CollectorProductView(),
    SellerProfileView()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.userModel != null) {
      checkUserBlock(widget.userModel!);
    }
  }

  checkUserBlock(UsersModel userModel) {
    if (userModel.isBlock == true) {
      pushUntil(context, BannedAccountView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        flag: false,
      ),
      body: Obx(() {
        return pages[collectorState.currentIndex.value];
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
            currentIndex: collectorState.currentIndex.value,
            onTap: collectorState.updateSelectedIndex,
            type: BottomNavigationBarType.fixed,
            // showSelectedLabels: false,
            selectedItemColor: AppColors.appColor,
            backgroundColor: AppColors.whiteColor,
            elevation: 20,
            selectedLabelStyle: TextStyle(
                color: AppColors.appColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(
                color: AppColors.blackColor.withOpacity(.5),
                fontSize: 10.sp,
                fontWeight: FontWeight.w500),
            selectedIconTheme:
                IconThemeData(color: AppColors.appColor, size: 35.sp),
            unselectedIconTheme: IconThemeData(
                color: AppColors.blackColor.withOpacity(.5), size: 25.sp),
            landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/home.png",
                  height: collectorState.currentIndex.value == 0 ? 40.h : 25.h,
                ),
                label: "Home".tr,
              ),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/images/bidings.png",
                    height:
                        collectorState.currentIndex.value == 1 ? 40.h : 25.h,
                  ),
                  label: "Bids".tr),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/images/profile.png",
                    height:
                        collectorState.currentIndex.value == 2 ? 40.h : 25.h,
                  ),
                  label: "Profile".tr),
            ]);
      }),
    );
  }
}

class UserHomeBoxWidget extends StatelessWidget {
  final String? boxName;
  final String? boxImage;
  final Function()? onTap;
  const UserHomeBoxWidget({super.key, this.boxName, this.boxImage, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 300.w,
        padding: EdgeInsets.all(15.sp),
        // margin: EdgeInsets.only(right: 10.w, left: 5.w),
        decoration: BoxDecoration(
            color: AppColors.appColor.withOpacity(.05),
            border: Border.all(color: AppColors.blackColor.withOpacity(.25)),
            borderRadius: BorderRadius.circular(6.sp)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              boxImage ?? "assets/images/buy_sell.png",
              height: 60.h,
            ),
            10.h.sizedBoxHeight,
            Text(
              boxName ?? "Undefined",
              style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
