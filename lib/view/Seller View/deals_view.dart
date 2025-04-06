import 'package:digital_kabaria_app/common/custom_button.dart';
import 'package:digital_kabaria_app/common/custom_text_form_field.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:digital_kabaria_app/view/Seller%20View/buy_scraps_view.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DealsView extends StatefulWidget {
  const DealsView({super.key});

  @override
  State<DealsView> createState() => _DealsViewState();
}

class _DealsViewState extends State<DealsView> {
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
          //       "Deals",
          //       style: TextStyle(
          //           color: AppColors.whiteColor,
          //           fontSize: 18.sp,
          //           fontWeight: FontWeight.w500),
          //     )),
          //   ),
          // ),
          // 10.h.sizedBoxHeight,
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.all(15.sp),
              children: List.generate(
                5,
                (index) => ClipRRect(
                  borderRadius: BorderRadius.circular(8.sp),
                  child: Container(
                    width: double.infinity,

                    // padding: EdgeInsets.all(15.sp),
                    margin: EdgeInsets.only(bottom: 10.h),
                    decoration: BoxDecoration(
                        color: AppColors.appColor.withOpacity(.10),
                        border: Border.all(
                            color: AppColors.blackColor.withOpacity(.1)),
                        borderRadius: BorderRadius.circular(8.sp)),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/old_scrap.png",
                          height: 150.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0.sp),
                          child: Row(
                            children: [
                              Text(
                                "Old Table",
                                style: TextStyle(
                                    color: AppColors.blackColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              Text(
                                "1000 PKR",
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur",
                                style: TextStyle(
                                    color: AppColors.blackColor.withOpacity(.5),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        buildScrapDetails(key: "Location", value: "Islamabad"),
                        buildScrapDetails(
                            key: "Nearby Address",
                            value: "Sufi Bakers, Sadiqabbad"),
                        buildScrapDetails(key: "Status", value: "In Progress"),
                        buildScrapDetails(
                            key: "Purchased By", value: "Usman Muaz"),
                        buildScrapDetails(key: "Price", value: "1000 PKR"),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0.w, vertical: 10.h),
                            child: CustomButton(
                              text: "Check In",
                              onPressed: () {
                                reportUserDailogue(context);
                              },
                            )),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0.w, vertical: 10.h),
                            child: CustomButton(
                              text: "Report User",
                              onPressed: () {
                                reportUserDailogue(context);
                              },
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    ;
  }
}

// Bid Dialogue
void reportUserDailogue(
  BuildContext context,
) {
  TextEditingController reportReason = TextEditingController();
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
                  'Report User!',
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
                'Report Reason:',
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
                controller: reportReason,
                hintText: "write your reason...?",
                maxLines: 5,
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(
                height: 15.h,
              ),
              Center(
                  child: CustomButton(
                text: "Report",
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
            ],
          ),
        ),
      );
    },
  );



}
