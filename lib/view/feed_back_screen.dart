import 'package:digital_kabaria_app/Common/app_loader.dart';
import 'package:digital_kabaria_app/Common/custom_app_bar.dart';
import 'package:digital_kabaria_app/Common/custom_button.dart';
import 'package:digital_kabaria_app/Common/custom_text_form_field.dart';
import 'package:digital_kabaria_app/Utils/app_text.dart';
import 'package:digital_kabaria_app/Utils/sized_box_extension.dart';
import 'package:digital_kabaria_app/controllers/feed_back_controller.dart';
import 'package:digital_kabaria_app/view/Seller%20View/Auth%20View/Auth%20State/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  final controller = Get.put(FeedBackController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: const CustomAppBar(
          flag: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: height * .05),
                const Center(
                  child: AppText(
                    text: "Feedback",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height * .08),
                CustomTextFormField(
                  hintText: "Title",
                  controller: title,
                ),
                20.h.sizedBoxHeight,
                CustomTextFormField(
                  hintText: "Description",
                  controller: description,
                  maxLines: 4,
                ),
                20.h.sizedBoxHeight,
                Obx(() {
                  return controller.isLoading.value
                      ? const Center(child: AppLoader())
                      : CustomButton(
                          onPressed: () {
                            controller.sendFeedback(context,
                                title: title.text,
                                description: description.text);
                          },
                          text: "Send",
                        );
                }),
              ],
            ),
          ),
        ));
  }
}
