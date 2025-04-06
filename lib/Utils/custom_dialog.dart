import 'package:digital_kabaria_app/Common/app_loader.dart';
import 'package:digital_kabaria_app/Utils/custom_navigation.dart';
import 'package:digital_kabaria_app/Utils/utils.dart';
import 'package:digital_kabaria_app/controllers/bid/bid_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Common/custom_button.dart';
import '../Common/custom_text_form_field.dart';
import 'app_colors.dart';

void showBidDialog(BuildContext context, TextEditingController controller,
    {productId,
    productName,
    productPrice,
    productDescription,
    productImage,
    name,
    }) {
  BidController bidController = Get.put(BidController());
  showDialog(
    context: context,
    builder: (context) {
    
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 40.h),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Send Bid!',
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
                'Bid Amount:',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.blackColor.withOpacity(.50),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              // DATE PICKER

              CustomTextFormField(
                controller: controller,
                hintText: "000",
                suffixIcon: IconButton(
                  onPressed: null,
                  icon: Text(
                    'PKR',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.blackColor.withOpacity(.50),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),

              SizedBox(
                height: 15.h,
              ),
              Center(child: Obx((){

                return  bidController.isLoading.value?const AppLoader(): CustomButton(
                  text: "Submit",
                  onPressed: () {
                    if (controller.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          "Please enter some amount", context);
                    } else if (controller.text.isNotEmpty) {
                      
                      bidController.sendBid(
                        context,
                          productName: productName,
                          productPrice: productPrice,
                          productImage: productImage,
                          productDescription: productDescription,
                          productId: productId,
                          name: name,
                          bidAmount: controller.text);
                          controller.clear();
                          
                          
                    }
                  },
                );
              
              }),)
           
            ],
          ),
        ),
      );
    },
  );
}
