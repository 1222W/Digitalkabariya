import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_kabaria_app/common/custom_button.dart';
import 'package:digital_kabaria_app/controllers/product/product_detail_controller.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:digital_kabaria_app/view/Seller%20View/view_bids_by_user.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class CompanyBidsview extends StatefulWidget {
  const CompanyBidsview({super.key});

  @override
  State<CompanyBidsview> createState() => _CompanyBidsviewState();
}

class _CompanyBidsviewState extends State<CompanyBidsview> {
  var controller = Get.put(ProductDetailController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ClipPath(
        //   clipper: OvalRightBorderClipper(),
        //   child: Container(
        //     height: 50.h,
        //     width: 150.w,
        //     color: AppColors.appColor,
        //     child: Center(
        //         child: Text(
        //       "Bids",
        //       style: TextStyle(
        //           color: AppColors.whiteColor,
        //           fontSize: 18.sp,
        //           fontWeight: FontWeight.w500),
        //     )),
        //   ),
        // ),
        10.h.sizedBoxHeight,
        Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: controller.getProductData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: Text('No products found'));
                  }
                  var snapDocsData = snapshot.data!.docs;

                  return ListView.builder(
                      itemCount: snapDocsData.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var data = snapDocsData[index];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8.sp),
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            width: double.infinity,
                            // padding: EdgeInsets.all(15.sp),
                            margin: EdgeInsets.only(bottom: 10.h),
                            decoration: BoxDecoration(
                                color: AppColors.appColor.withOpacity(.10),
                                border: Border.all(
                                    color:
                                        AppColors.blackColor.withOpacity(.1)),
                                borderRadius: BorderRadius.circular(8.sp)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  "${data['images'][0]}",
                                  height: 150.h,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10.0.sp),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${data['name']}",
                                        style: TextStyle(
                                            color: AppColors.blackColor,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "${data['price']}",
                                        style: TextStyle(
                                            color: AppColors.appColor,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10.0.sp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Description:",
                                        style: TextStyle(
                                            color: AppColors.blackColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      10.h.sizedBoxHeight,
                                      Text(
                                        "${data['description']}",
                                        style: TextStyle(
                                            color: AppColors.blackColor
                                                .withOpacity(.5),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0.w, vertical: 10.h),
                                    child: CustomButton(
                                      text: "View All Bids",
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                child: BidsViewScreen(
                                                  productId: data.id,
                                                ),
                                                type: PageTransitionType
                                                    .rightToLeft));
                                      },
                                    ))
                              ],
                            ),
                          ),
                        );
                      });
                })),
      ],
    );
  }
}
