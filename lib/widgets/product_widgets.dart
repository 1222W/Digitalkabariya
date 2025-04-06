import 'package:digital_kabaria_app/Utils/app_strings.dart';
import 'package:digital_kabaria_app/Utils/app_text.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class NumberWidget extends StatelessWidget {
  final numberOne, numberTwo;
  const NumberWidget({super.key, this.numberOne, this.numberTwo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          text: AppStrings.numberOne,
          fontSize: 14,
          color: AppColors.appColor,
          fontWeight: FontWeight.bold,
          maxLines: 2,
        ),
        AppText(
          text: numberOne,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          maxLines: 2,
        ),
        AppText(
          text: AppStrings.numberTwo,
          color: AppColors.appColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          maxLines: 2,
        ),
        AppText(
          text: numberTwo,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          maxLines: 2,
        ),
      ],
    );
  }
}

class ProductAdrees extends StatelessWidget {
  final address;
  const ProductAdrees({super.key, this.address});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          text: AppStrings.address,
          color: AppColors.appColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          maxLines: 2,
        ),
        AppText(
          text: address,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          maxLines: 2,
        ),
      ],
    );
  }
}
