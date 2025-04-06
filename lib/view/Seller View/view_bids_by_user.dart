import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_kabaria_app/Utils/app_text.dart';
import 'package:digital_kabaria_app/common/custom_app_bar.dart';
import 'package:digital_kabaria_app/common/custom_button.dart';
import 'package:digital_kabaria_app/controllers/bid/bid_controller.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:digital_kabaria_app/view/Seller%20View/buy_scraps_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BidsViewScreen extends StatefulWidget {
  String productId;
   BidsViewScreen({super.key,this.productId = ""});

  @override
  State<BidsViewScreen> createState() => _BidsViewScreenState();
}

class _BidsViewScreenState extends State<BidsViewScreen> {
  var controller = Get.put(BidController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        flag: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipPath(
            clipper: OvalRightBorderClipper(),
            child: Container(
              height: 50.h,
              width: 150.w,
              color: AppColors.appColor,
              child: Center(
                  child: Text(
                "Company Bids",
                style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500),
              )),
            ),
          ),
          10.h.sizedBoxHeight,
          Expanded(child: StreamBuilder<QuerySnapshot>(
            stream: controller.getBids(productId: widget.productId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                const Center(child: AppText(text: "someThing went wrong",),);
              }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),); 
            }
               if (!snapshot.hasData) {
            return const Center(child: Text('No Bids found'));
          }
        var snapDocs =  snapshot.data!.docs;
        
             
              return ListView.builder(
                itemCount: snapDocs.length,
                itemBuilder: (context, index) {
              var data =    snapDocs[index];
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 10.h, right: 10.h, left: 10.0),
                  decoration: BoxDecoration(
                      color: AppColors.appColor.withOpacity(.10),
                      border:
                          Border.all(color: AppColors.blackColor.withOpacity(.1)),
                      borderRadius: BorderRadius.circular(8.sp)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildScrapDetails(key: "Bid By", value: "${data['name']}"),
                      buildScrapDetails(key: "Bid Amount", value: "${data['bidAmount']} PKR"),
                      buildScrapDetails(key: "Orignal Price", value: "${data['productPrice']} PKR"),
                      buildScrapDetails(key: "type", value: "Pick Up"),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 10.h),
                        child: Row(
                          children: [
                            Expanded(
                                child: CustomButton(
                              text: "Accept",
                              onPressed: () async{
                                // debugger();
                               await controller.bidAccepted(bidId: data.id,productId: widget.productId);
                              },
                            )),
                            10.w.sizedBoxWidth,
                            Expanded(
                                child: CustomButton(
                              text: "Reject",
                              btnColor: AppColors.whiteColor,
                              textColor: AppColors.blackColor,
                              onPressed: () async{
                               await controller.bidRejected(bidId: data.id,productId: widget.productId);

                              },
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              });
            }
          )),
        ],
      ),
    );
  }
}
