import 'package:digital_kabaria_app/common/custom_app_bar.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:digital_kabaria_app/view/Admin%20Side%20View/Admin%20Side%20State/my_videos_state.dart';
import 'package:digital_kabaria_app/view/Admin%20Side%20View/Admin%20Side%20Tabs/organizations_tab.dart';
import 'package:digital_kabaria_app/view/Admin%20Side%20View/Admin%20Side%20Tabs/users_tab.dart';
import 'package:digital_kabaria_app/view/Admin%20Side%20View/Admin%20Side%20Tabs/complaints_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdminSideView extends StatefulWidget {
  const AdminSideView({super.key});

  @override
  State<AdminSideView> createState() => _AdminSideViewState();
}

class _AdminSideViewState extends State<AdminSideView>
    with SingleTickerProviderStateMixin {
  // Variables and States
  late TabController _tabController;
  final adminState = Get.put(AdminState());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3, vsync: this, initialIndex: adminState.currentTabIndex.value);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabController.length,
      child: Scaffold(
        appBar: const CustomAppBar(
          flag: true,
        ),
        body: Column(
          children: [
            // ================== Tab Bars ===================== //
            Container(
                // height: 50.h,
                width: double.infinity,
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8.sp),
                  // boxShadow: [
                  //   BoxShadow(
                  //       color: AppColors.blackColor.withOpacity(.15),
                  //       blurRadius: 2.5,
                  //       spreadRadius: 2.5)
                  // ]
                ),
                child: Column(
                  children: [
                    buildDashboardData(
                        dataName: "Overall Users",
                        data: "9",
                        dataColor: AppColors.appColor),
                    buildDashboardData(
                        dataName: "Active Users",
                        data: "9",
                        dataColor: Colors.green),
                    buildDashboardData(
                        dataName: "Suspended Users",
                        data: "10",
                        dataColor: AppColors.redColor),
                  ],
                )),

            10.h.sizedBoxHeight,
            GetBuilder<AdminState>(builder: (myVideoState) {
              return TabBar(
                  indicatorColor: AppColors.appColor,
                  overlayColor: WidgetStateProperty.all(
                      AppColors.tealColor.withOpacity(.10)),
                  onTap: myVideoState.updateCurrenttab,
                  dividerColor: AppColors.blackColor.withOpacity(.25),
                  dividerHeight: 0.5.h,
                  controller: _tabController,
                  tabs: [
                    buildTab(
                        tabColor: _tabController.index == 0
                            ? AppColors.appColor
                            : AppColors.blackColor,
                        tabIcon: Icons.person,
                        tabName: "Users"),
                    buildTab(
                        tabColor: _tabController.index == 1
                            ? AppColors.appColor
                            : AppColors.blackColor,
                        tabIcon: Icons.block,
                        tabName: "Blocked"),
                    buildTab(
                        tabColor: _tabController.index == 2
                            ? AppColors.appColor
                            : AppColors.blackColor,
                        tabIcon: Icons.group,
                        tabName: "Approvals"),
                  ]);
            }),
            // ================== Tab Bar View For Videos ===================== //
            Expanded(
                child: TabBarView(controller: _tabController, children: const [
              UsersTab(),
              ComplaintsTab(),
              OrganizationTabs()
            ]))
          ],
        ),
      ),
    );
  }
}

// ============= Tab ============ //

Widget buildTab(
    {required String tabName, required tabColor, required IconData tabIcon}) {
  return SizedBox(
      height: 50.h,
      width: 120.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            tabIcon,
            color: tabColor,
            size: 20.sp,
          ),
          Text(
            tabName,
            style: TextStyle(
                color: tabColor, fontSize: 13.sp, fontWeight: FontWeight.w600),
          ),
        ],
      ));
}

//

buildDashboardData({
  required String dataName,
  String? data,
  required Color dataColor,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.h),
    child: Row(
      children: [
        Container(
          height: 15.h,
          width: 15.sp,
          decoration: BoxDecoration(
            color: dataColor,
            shape: BoxShape.circle,
          ),
        ),
        5.w.sizedBoxWidth,
        Text(
          dataName,
          style: TextStyle(
              color: AppColors.blackColor.withOpacity(.5),
              fontSize: 11.sp,
              fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        Text(
          data ?? "data",
          style: TextStyle(
              color: AppColors.blackColor.withOpacity(.5),
              fontSize: 11.sp,
              fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}

buildHorizotalData({
  required String key,
  required String value,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.h),
    child: Row(
      children: [
        Text(
          key,
          style: TextStyle(
              color: AppColors.blackColor.withOpacity(.5),
              fontSize: 12.sp,
              fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        SizedBox(
          // width: 150.w,
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: TextStyle(
                color: value == "Active"
                    ? AppColors.blackColor
                    : value == "Blocked"
                        ? AppColors.redColor
                        : AppColors.blackColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}
