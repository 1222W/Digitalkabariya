import 'package:digital_kabaria_app/common/custom_button.dart';
import 'package:digital_kabaria_app/common/custom_text_form_field.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuyScrapsView extends StatefulWidget {
  const BuyScrapsView({super.key});

  @override
  State<BuyScrapsView> createState() => _BuyScrapsViewState();
}

class _BuyScrapsViewState extends State<BuyScrapsView> {
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
        //     color: AppColors.brownColor,
        //     child: Center(
        //         child: Text(
        //       "Buy Scraps",
        //       style: TextStyle(
        //           color: AppColors.whiteColor,
        //           fontSize: 18.sp,
        //           fontWeight: FontWeight.w500),
        //     )),
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 5.h),
          child: CustomTextFormField(
            hintText: "Search Scraps...",
            prefixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: AppColors.blackColor.withOpacity(.5),
                )),
          ),
        ),
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
                      20.w.sizedBoxWidth,
                      buildScrapDetails(key: "Material", value: "Old Table"),
                      buildScrapDetails(key: "Location", value: "Islamabad"),
                      buildScrapDetails(key: "Status", value: "Available"),
                      buildScrapDetails(key: "Owner", value: "Usman Muaz"),
                      buildScrapDetails(key: "Price", value: "1000 PKR"),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0.w, vertical: 10.h),
                        child: Row(
                          children: [
                            Expanded(
                                child: CustomButton(
                              text: "Buy",
                              onPressed: () {},
                            )),
                            10.w.sizedBoxWidth,
                            Expanded(
                                child: CustomButton(
                              text: "Send Bid",
                              btnColor: AppColors.whiteColor,
                              textColor: AppColors.blackColor,
                              onPressed: () {
                                bidDialogue(context);
                              },
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Build Scrap Details Text

Widget buildScrapDetails({required String key, required String value}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.0.sp, vertical: 5.h),
    child: Row(
      children: [
        Text(
          key,
          style: TextStyle(
              color: AppColors.blackColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
              color: AppColors.blackColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

// Bid Dialogue
void bidDialogue(
  BuildContext context,
) {
  TextEditingController bidAmount = TextEditingController();
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
                controller: bidAmount,
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
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(
                height: 15.h,
              ),
              Center(
                  child: CustomButton(
                text: "Submit",
                onPressed: () {},
              )),
            ],
          ),
        ),
      );
    },
  );
}
