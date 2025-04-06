import 'package:digital_kabaria_app/common/custom_button.dart';
import 'package:digital_kabaria_app/common/custom_text_form_field.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/app_text.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SellerUpdateProfile extends StatelessWidget {
  const SellerUpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            SizedBox(
              height: height * .08,
            ),
            const Center(
                child: AppText(
              text: "Update Profile",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
            SizedBox(
              height: height * .08,
            ),
            const CustomTextFormField(
              readOnly: true,
              flag: false,
              hintText: "Ahsan Khan",
            ),
            20.h.sizedBoxHeight,
            const CustomTextFormField(
              readOnly: true,
              hintText: "ahsan@gmail.com",
            ),
            20.h.sizedBoxHeight,
            const CustomTextFormField(
              readOnly: true,
              hintText: "032434343",
            ),
            20.h.sizedBoxHeight,
            CustomButton(
              onPressed: () {},
              text: "Update",
            ),
          ],
        ),
      ),
    );
  }
}
