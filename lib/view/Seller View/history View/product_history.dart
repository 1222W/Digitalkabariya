import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_kabaria_app/common/custom_app_bar.dart';
import 'package:digital_kabaria_app/common/custom_button.dart';
import 'package:digital_kabaria_app/controllers/seller_controllers/seller_product_controller.dart';
import 'package:digital_kabaria_app/model/product_model.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/custom_navigation.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:digital_kabaria_app/view/product/add_product_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductHistoryScreen extends StatefulWidget {
  const ProductHistoryScreen({super.key});

  @override
  State<ProductHistoryScreen> createState() => _ProductHistoryScreenState();
}

class _ProductHistoryScreenState extends State<ProductHistoryScreen> {
  SellerProductController controller = Get.put(SellerProductController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: GestureDetector(
                      onTap: () {
                        pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 25,
                        color: Colors.black,
                      )),
                ),
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
                          if (!snapshot.hasData) {
                            return const Center(
                                child: Text('No products found'));
                          }
                          var snapDocsData = snapshot.data;

                          return ListView.builder(
                              itemCount: snapDocsData!.length,
                              itemBuilder: (context, index) {
                                var data = snapDocsData[index];
                                return data.isSold == false
                                    ? SizedBox()
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.sp),
                                        child: Container(
                                          width: double.infinity,

                                          // padding: EdgeInsets.all(15.sp),
                                          margin: EdgeInsets.only(bottom: 10.h),
                                          decoration: BoxDecoration(
                                              color: AppColors.appColor
                                                  .withOpacity(.10),
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
                                                padding:
                                                    EdgeInsets.all(10.0.sp),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      data.name,
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .blackColor,
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    // const Spacer(),
                                                    // Text(
                                                    //   "${data.price} PKR",
                                                    //   style: TextStyle(
                                                    //       color: AppColors.appColor,
                                                    //       fontSize: 18.sp,
                                                    //       fontWeight: FontWeight.bold),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.all(10.0.sp),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Price Range:",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .blackColor,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    10.h.sizedBoxHeight,
                                                    Text(
                                                      data.price,
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .blackColor
                                                              .withOpacity(.5),
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8.0.w,
                                                      vertical: 10.h),
                                                  child: CustomButton(
                                                    text: "Sold Out!",
                                                    btnColor: Colors.green,
                                                    onPressed: () async {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'products')
                                                          .doc(data.docId)
                                                          .delete();
                                                      setState(() {
                                                        snapDocsData.removeWhere(
                                                            (item) =>
                                                                item.docId ==
                                                                data.docId);
                                                      });
                                                    },
                                                  )),
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
            text: "Post New",
            btnWidth: 200,
            btnColor: AppColors.whiteColor,
            textColor: AppColors.blackColor,
            border: BorderSide(color: AppColors.blackColor.withOpacity(.5)),
            onPressed: () {
              push(context, const AddPostScreen());
            },
          )),
    );
  }
}

// deletePostedMaterial Dialogue
void deletePostedMaterial(
  BuildContext context,
  final docId,
) {
  showDialog(
    context: context,
    builder: (context) {
      SellerProductController controller = Get.put(SellerProductController());

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
                      controller.deleteProduct(docId, context);
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
