import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_kabaria_app/common/custom_button.dart';
import 'package:digital_kabaria_app/controllers/users/users_controller.dart';
import 'package:digital_kabaria_app/model/users.model.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/app_strings.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:digital_kabaria_app/view/Admin%20Side%20View/admin_side_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrganizationTabs extends StatefulWidget {
  const OrganizationTabs({super.key});

  @override
  State<OrganizationTabs> createState() => _UsersTabState();
}

class _UsersTabState extends State<OrganizationTabs> {
  UsersController controller = Get.put(UsersController());
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: controller.getAgencyData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          QuerySnapshot? userData = snapshot.data;
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final data = userData!.docs;
            // debugger();s

            List<UsersModel> getUser = usersModelFromJson(data);
            // debugger();
            return ListView.builder(
                // shrinkWrap: true,
                itemCount: getUser.length,
                itemBuilder: (context, index) {
                  UsersModel user = getUser[index];
                  final id = data[index].id;
                  // final farmerDetails = dashboardData[index];
                  return Container(
                      // height: 50.h,
                      width: double.infinity,
                      padding: EdgeInsets.all(15.sp),
                      margin: EdgeInsets.only(
                          bottom: 5.sp, top: 10, left: 15.w, right: 15.w),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8.sp),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.blackColor.withOpacity(.15),
                                blurRadius: 2.5,
                                spreadRadius: 2.5)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildHorizotalData(
                              key: "Full Name:", value: user.fullName!),
                          buildHorizotalData(
                              key: "Email:", value: user.emailAddress!),
                          buildHorizotalData(key: "Role", value: user.role!),
                          10.h.sizedBoxHeight,

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButton(
                                btnHeight: 40,
                                btnWidth: 100,
                                onPressed: () {
                                  controller.updateValue(
                                      id: id, key: "is_verify", value: false);
                                },
                                text: AppStrings.deny,
                                btnColor: AppColors.redColor,
                              ),
                              CustomButton(
                                btnHeight: 40,
                                btnWidth: 100,
                                onPressed: () {
                                  controller.updateValue(
                                      id: id, key: "is_verify", value: true);
                                },
                                text: AppStrings.accept,
                                btnColor: AppColors.greenColor,
                              ),
                            ],
                          ),
                          // 10.h.sizedBoxHeight,
                        ],
                      ));
                });
          }
        });
  }
}
