// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_kabaria_app/common/custom_button.dart';
import 'package:digital_kabaria_app/controllers/users/users_controller.dart';
import 'package:digital_kabaria_app/model/users.model.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:digital_kabaria_app/view/Admin%20Side%20View/admin_side_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ComplaintsTab extends StatefulWidget {
  const ComplaintsTab({super.key});

  @override
  State<ComplaintsTab> createState() => _ComplaintsTabState();
}

class _ComplaintsTabState extends State<ComplaintsTab> {
  UsersController controller = Get.put(UsersController());
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: controller.getUsersData(),
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
            final data =
                userData!.docs.where((val) => val.get('isBlock') == true);
            // debugger();s

            List<UsersModel> getUser = usersModelFromJson(data);
            // debugger();
            return getUser.isEmpty
                ? Center(
                    child: Text("No Block User Found!"),
                  )
                : ListView.builder(
                    // shrinkWrap: true,
                    itemCount: getUser.length,
                    itemBuilder: (context, index) {
                      UsersModel user = getUser[index];
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
                                    color:
                                        AppColors.blackColor.withOpacity(.15),
                                    blurRadius: 2.5,
                                    spreadRadius: 2.5)
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              buildHorizotalData(
                                  key: "Full Name:", value: user.fullName!),
                              buildHorizotalData(
                                  key: "Email:", value: user.emailAddress!),
                              buildHorizotalData(
                                  key: "Role", value: user.role!),
                              10.h.sizedBoxHeight,

                              CustomButton(
                                btnHeight: 40,
                                btnWidth: 120,
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user.userId)
                                      .update({"isBlock": false});
                                  getUser.removeWhere(
                                      (item) => item.userId == user.userId);
                                },
                                text: "UnBLock",
                              ),
                              // 10.h.sizedBoxHeight,
                            ],
                          ));
                    });
          }
        });
  }
}
