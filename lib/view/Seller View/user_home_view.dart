import 'package:digital_kabaria_app/common/custom_app_bar.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';

import 'package:digital_kabaria_app/view/Seller%20View/User%20State/user_state.dart';
import 'package:digital_kabaria_app/view/Seller%20View/buy_scraps_view.dart';
import 'package:digital_kabaria_app/view/Seller%20View/deals_view.dart';
import 'package:digital_kabaria_app/view/Seller%20View/posted_materials_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserHomeView extends StatefulWidget {
  const UserHomeView({super.key});

  @override
  State<UserHomeView> createState() => _UserHomeViewState();
}

class _UserHomeViewState extends State<UserHomeView> {
  // Variables && States
  final userState = Get.put(UserState());
  final List<Widget> pages = [
    const BuyScrapsView(),
    const SellerProductView(),
    // const BidsView(),
    // Placeholder(),
    const DealsView()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        flag: true,
      ),
      body: Obx(() {
        return pages[userState.currentIndex.value];
      }),
      // body: SingleChildScrollView(
      //   physics: const BouncingScrollPhysics(),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       ClipPath(
      //         clipper: OvalRightBorderClipper(),
      //         child: Container(
      //           height: 50.h,
      //           width: 150.w,
      //           color: AppColors.appColor,
      //           child: Center(
      //               child: Text(
      //             "Home",
      //             style: TextStyle(
      //                 color: AppColors.whiteColor,
      //                 fontSize: 18.sp,
      //                 fontWeight: FontWeight.w500),
      //           )),
      //         ),
      //       ),
      //       20.h.sizedBoxHeight,
      //       GridView.count(
      //         crossAxisCount: 2,
      //         physics: const NeverScrollableScrollPhysics(),
      //         shrinkWrap: true,
      //         mainAxisSpacing: 10.w,
      //         crossAxisSpacing: 10.h,
      //         padding: EdgeInsets.all(15.sp),
      //         children: [
      //           UserHomeBoxWidget(
      //             boxName: "Buy Scraps",
      //             boxImage: "assets/images/buy_sell.png",
      //             onTap: () {
      //               Navigator.push(
      //                   context,
      //                   PageTransition(
      //                       child: const BuyScrapsView(),
      //                       type: PageTransitionType.rightToLeft));
      //             },
      //           ),
      //           UserHomeBoxWidget(
      //             boxName: "Sell Sraps",
      //             boxImage: "assets/images/my_posts.png",
      //             onTap: () {
      //               Navigator.push(
      //                   context,
      //                   PageTransition(
      //                       child: const PostedMaterialView(),
      //                       type: PageTransitionType.rightToLeft));
      //             },
      //           ),
      //           UserHomeBoxWidget(
      //             boxName: "Biddings",
      //             boxImage: "assets/images/bidings.png",
      //             onTap: () {
      //               Navigator.push(
      //                   context,
      //                   PageTransition(
      //                       child: const BidsView(),
      //                       type: PageTransitionType.rightToLeft));
      //             },
      //           ),
      //           UserHomeBoxWidget(
      //             boxName: "Deals",
      //             boxImage: "assets/images/deal.png",
      //             onTap: () {
      //               Navigator.push(
      //                   context,
      //                   PageTransition(
      //                       child: const DealsView(),
      //                       type: PageTransitionType.rightToLeft));
      //             },
      //           ),
      //         ],
      //       ),
      //       Padding(
      //         padding: EdgeInsets.all(15.sp),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text(
      //               "Scrap Rates in Pakistan:",
      //               style: TextStyle(
      //                   color: AppColors.blackColor,
      //                   fontSize: 18.sp,
      //                   fontWeight: FontWeight.w600),
      //             ),
      //             10.h.sizedBoxHeight,
      //             buildScrapDetails(key: "Metal / Loha", value: "180 per KG"),
      //             buildScrapDetails(
      //                 key: "Paper / Radi Kaghaz", value: "60 per KG"),
      //             buildScrapDetails(
      //                 key: "Copper / Tamba", value: "2400 per KG"),
      //             buildScrapDetails(key: "Plastic Scrap", value: "70 per KG"),
      //             buildScrapDetails(key: "Steel Scrap", value: "240 per KG"),
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      // floatingActionButton:  CustomButton(
      //       text: "Sell?",
      //       btnWidth: 100,
      //       btnColor: AppColors.appColor,
      //       textColor: AppColors.whiteColor,

      //       border: BorderSide(color: AppColors.blackColor.withOpacity(.5)),
      //       onPressed: () {},
      //     ),

      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
            currentIndex: userState.currentIndex.value,
            onTap: userState.updateSelectedIndex,
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
                  "assets/images/buy_sell.png",
                  height: userState.currentIndex.value == 0 ? 40.h : 25.h,
                ),
                label: "Buy",
              ),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/images/my_posts.png",
                    height: userState.currentIndex.value == 1 ? 40.h : 25.h,
                  ),
                  label: "Sell"),
              // BottomNavigationBarItem(
              //     icon: Image.asset(
              //       "assets/images/bidings.png",
              //       height: userState.currentIndex.value == 2 ? 40.h : 25.h,
              //     ),
              //     label: "Bids"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/images/deal.png",
                    height: userState.currentIndex.value == 3 ? 40.h : 25.h,
                  ),
                  label: "Deals"),
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
