import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_kabaria_app/common/custom_button.dart';
import 'package:digital_kabaria_app/controllers/collector_controllers/collector_product_controller.dart';
import 'package:digital_kabaria_app/model/product_model.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/custom_navigation.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:digital_kabaria_app/view/Collector%20View/bids%20view/add_bids_post.dart';
import 'package:digital_kabaria_app/view/Collector%20View/bids%20view/view_all_bids.dart';
import 'package:digital_kabaria_app/view/Collector%20View/collector_add_product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CollectorProductView extends StatefulWidget {
  const CollectorProductView({super.key});

  @override
  State<CollectorProductView> createState() => _SellerProductViewState();
}

class _SellerProductViewState extends State<CollectorProductView> {
  CollectorProductController controller = Get.put(CollectorProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: StreamBuilder(
                      stream: controller.getProductData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                              child: Text('Something went wrong'));
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No products found'));
                        }
                        var snapDocsData = snapshot.data;

                        return ListView.builder(
                            itemCount: snapDocsData!.length,
                            itemBuilder: (context, index) {
                              ProductModel data = snapDocsData[index];
                              log("ProducModel$index : ${snapDocsData[index]}");

                              return ClipRRect(
                                borderRadius: BorderRadius.circular(8.sp),
                                child: Container(
                                  width: double.infinity,

                                  // padding: EdgeInsets.all(15.sp),
                                  margin: EdgeInsets.only(bottom: 10.h),
                                  decoration: BoxDecoration(
                                      color:
                                          AppColors.appColor.withOpacity(.10),
                                      border: Border.all(
                                          color: AppColors.blackColor
                                              .withOpacity(.1)),
                                      borderRadius:
                                          BorderRadius.circular(8.sp)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        data.images.first,
                                        height: 150.h,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10.0.sp),
                                        child: Row(
                                          children: [
                                            Text(
                                              data.name,
                                              style: TextStyle(
                                                  color: AppColors.blackColor,
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
                                              "Description:".tr,
                                              style: TextStyle(
                                                  color: AppColors.blackColor,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            10.h.sizedBoxHeight,
                                            Text(
                                              data.description,
                                              style: TextStyle(
                                                  color: AppColors.blackColor
                                                      .withOpacity(.5),
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0.w,
                                                  vertical: 10.h),
                                              child: CustomButton(
                                                text: "VIew All Bids".tr,
                                                btnWidth: 150,
                                                onPressed: () {
                                                  log("Id selected : ${data.docId}");
                                                  push(
                                                      context,
                                                      ViewAllBidsScreen(
                                                        productModel: data,
                                                      ));
                                                },
                                              )),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0.w,
                                                  vertical: 10.h),
                                              child: CustomButton(
                                                text: "Delete".tr,
                                                btnWidth: 150,
                                                onPressed: () {
                                                  deletePostedMaterial(
                                                      context, data.docId);
                                                },
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      })),
            ],
          ),
        ),
        floatingActionButton: CustomButton(
          text: "Post Bid".tr,
          btnWidth: 200,
          btnColor: AppColors.whiteColor,
          textColor: AppColors.blackColor,
          border: BorderSide(color: AppColors.blackColor.withOpacity(.5)),
          onPressed: () {
            push(context, const AddPostBidScreen());
          },
        ));
  }
}

// deletePostedMaterial Dialogue
void deletePostedMaterial(
  BuildContext context,
  var docId,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 40.h),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Delete Post!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Are you sure you want to delete this post?',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.blackColor.withOpacity(.50),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              // DATE PICKER

              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Expanded(
                      child: CustomButton(
                    text: "Confirm",
                    onPressed: () {
                      CollectorProductController controller =
                          Get.put(CollectorProductController());
                      controller.deleteProduct(context, docId);
                      pop(context);
                    },
                  )),
                  10.w.sizedBoxWidth,
                  Expanded(
                      child: CustomButton(
                    text: "Cancel",
                    btnColor: AppColors.whiteColor,
                    textColor: AppColors.blackColor,
                    border:
                        BorderSide(color: AppColors.appColor.withOpacity(.5)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
