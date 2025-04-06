import 'package:flutter/material.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomDropdownWidget extends StatefulWidget {
  final String? hintText;
  final TextStyle? hintStyle;
  final String? errorText;
  final List<String> items;
  final Function(String)? onItemSelected;
  final TextEditingController controller;

  const CustomDropdownWidget({
    Key? key,
    required this.items,
    this.hintText,
    this.hintStyle,
    this.errorText,
    this.onItemSelected,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomDropdownWidget> createState() => _CustomDropdownWidgetState();
}

class _CustomDropdownWidgetState extends State<CustomDropdownWidget> {
  bool isOtherSelected = false;
  final TextEditingController otherController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Add "Others" to the dropdown list
    final itemsWithOthers = [...widget.items, "Others".tr];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          value: itemsWithOthers.contains(widget.controller.text) &&
                  !isOtherSelected
              ? widget.controller.text.tr
              : null,
          items: itemsWithOthers
              .toSet()
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item.tr),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              if (value == "Others".tr) {
                setState(() {
                  isOtherSelected = true;
                  widget.controller.text = ""; // Clear main controller
                  otherController.clear(); // Clear other input
                });
              } else {
                setState(() {
                  isOtherSelected = false;
                  widget.controller.text = value;
                });
                if (widget.onItemSelected != null) {
                  widget.onItemSelected!(value);
                }
              }
            }
          },
          decoration: InputDecoration(
            hintText: widget.hintText ?? 'Select Scrap Type'.tr,
            fillColor: AppColors.whiteColor,
            filled: true,
            errorText: widget.errorText,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
            hintStyle: widget.hintStyle ??
                TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.blackColor.withOpacity(.50),
                  fontWeight: FontWeight.w500,
                ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.sp),
              borderSide: BorderSide(
                color: AppColors.blackColor.withOpacity(.25),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.sp),
              borderSide: const BorderSide(
                color: AppColors.appColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.sp),
              borderSide: const BorderSide(
                color: AppColors.redColor,
              ),
            ),
          ),
        ),
        if (isOtherSelected)
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: TextFormField(
              controller: otherController,
              onChanged: (value) {
                widget.controller.text = value; // Update main controller
                if (widget.onItemSelected != null) {
                  widget.onItemSelected!(value);
                }
              },
              onFieldSubmitted: (value) {
                setState(() {
                  widget.controller.text = value; // Finalize input
                  isOtherSelected = false; // Optionally close input field
                });
              },
              validator: (val) {
                if (val!.isEmpty) {
                  return "Enter field data";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Enter your own value".tr,
                fillColor: AppColors.whiteColor,
                filled: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.blackColor.withOpacity(.50),
                  fontWeight: FontWeight.w500,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                  borderSide: BorderSide(
                    color: AppColors.blackColor.withOpacity(.25),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                  borderSide: const BorderSide(
                    color: AppColors.appColor,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
