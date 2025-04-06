import 'dart:math';

import 'package:digital_kabaria_app/Common/custom_button.dart';
import 'package:digital_kabaria_app/Common/custom_text_form_field.dart';
import 'package:digital_kabaria_app/Common/logout_alert.dart';
import 'package:digital_kabaria_app/Utils/app_text.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/view/charts/interaction_chart.dart';
import 'package:digital_kabaria_app/view/charts/line_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class HomeCardWidget extends StatefulWidget {
  double? height;
  double? width;
  IconData? icons;
  String title;
  String subTitle;
  HomeCardWidget(
      {super.key,
      this.height = 100,
      this.width = 100,
      this.icons = Icons.abc,
      this.title = "",
      this.subTitle = ""});

  @override
  State<HomeCardWidget> createState() => _HomeCardWidgetState();
}

class _HomeCardWidgetState extends State<HomeCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: AppColors.greyColor,
          borderRadius: BorderRadius.circular(10.0)),
      height: widget.height,
      width: widget.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            widget.icons,
            size: 40,
          ),
          AppText(
            text: widget.title,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          AppText(
            text: widget.subTitle,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.60,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10.0)),
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: AppText(
                text: "Overview",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Container(width: double.infinity, child: InteractionChartWidget())
          ],
        ));
  }
}

class ProfileComponentWidget extends StatelessWidget {
  const ProfileComponentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.whiteColor,
            child: Icon(
              Icons.person,
              size: 50,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const AppText(
            text: "Admin",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: AppColors.redColor),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 13.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.logout, color: AppColors.whiteColor),
                  AppText(
                    onTap: () {
                      showLogoutDialog(context);
                    },
                    text: "Sign out",
                    color: AppColors.whiteColor,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
