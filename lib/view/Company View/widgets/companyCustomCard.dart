import 'package:digital_kabaria_app/Common/custom_button.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/app_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CompanyCustomCard extends StatelessWidget {
  final String? title;
  final String? description;
  final int? price;
  final images;
  final bool isPrice;
  final Widget buttonWidget;
  CompanyCustomCard(
      {super.key,
      required this.buttonWidget,
      this.title,
      this.description,
      this.price,
      this.images,
      this.isPrice = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyColor),
        borderRadius: BorderRadius.circular(5.0),
        color: AppColors.whiteColor,
      ),
      margin: const EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            height: 130,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                    image: NetworkImage(
                      images.toString(),
                    ),
                    fit: BoxFit.cover)),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: AppText(
                  text: title.toString(),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )),
                isPrice == true
                    ? Expanded(
                        child: Align(
                            alignment: Alignment.topRight,
                            child: AppText(
                              text: "${price}PKR",
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            )))
                    : SizedBox(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5.0, left: 5.0, top: 5.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: AppText(
                text: description.toString(),
                fontWeight: FontWeight.w500,
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          buttonWidget,
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
