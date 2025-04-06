import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/app_text.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

  showCustomBottomSheet(context){
   return showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 100,width: double.infinity,
                color: AppColors.whiteColor,
                child:   Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const AppText(text: "Camera",fontSize: 15.0,color: AppColors.blackColor,fontWeight: FontWeight.bold,),
                    10.h.sizedBoxHeight,
                    const AppText(text: "Gallery",fontSize: 15.0,color: AppColors.blackColor,fontWeight: FontWeight.bold,)
                    ],
                  ),
                ));},);}
            