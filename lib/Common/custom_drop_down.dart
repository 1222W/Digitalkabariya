// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> dropdownItems;
  String selectedItem;
  bool isDropdownOpen;
  final ValueChanged<String> onChanged;

  CustomDropDown({
    Key? key,
    required this.dropdownItems,
    required this.selectedItem,
    required this.isDropdownOpen,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              widget.isDropdownOpen = !widget.isDropdownOpen;
            });
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.blackColor.withOpacity(.25)),
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.selectedItem,
                  style: const TextStyle(color: AppColors.appColor),
                ),
                Icon(widget.isDropdownOpen
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        5.h.sizedBoxHeight,
        Visibility(
          visible: widget.isDropdownOpen,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: widget.dropdownItems.map((item) {
                return ListTile(
                  title: Text(
                    item,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  onTap: () {
                    setState(() {
                      widget.selectedItem = item;
                      widget.isDropdownOpen = false;
                    });
                    widget.onChanged(item); // Call the callback function
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
