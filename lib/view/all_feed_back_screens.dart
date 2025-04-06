import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:digital_kabaria_app/Common/app_loader.dart';
import 'package:digital_kabaria_app/Common/custom_app_bar.dart';
import 'package:digital_kabaria_app/Common/custom_button.dart';
import 'package:digital_kabaria_app/Common/custom_text_form_field.dart';
import 'package:digital_kabaria_app/Utils/app_text.dart';
import 'package:digital_kabaria_app/Utils/sized_box_extension.dart';
import 'package:digital_kabaria_app/controllers/feed_back_controller.dart';

class AllFeedBackScreens extends StatefulWidget {
  const AllFeedBackScreens({super.key});

  @override
  State<AllFeedBackScreens> createState() => _AllFeedBackScreensState();
}

class _AllFeedBackScreensState extends State<AllFeedBackScreens> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  
  final controller = Get.put(FeedBackController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const CustomAppBar(flag: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: height * .05),
              const Center(
                child: AppText(
                  text: "ALL Feedbacks",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 20),
              // Feedback list
        Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: AppLoader());
                }
                if (controller.feedbackList.isEmpty) {
                  return const Center(child: Text("No Feedback Available"));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.feedbackList.length,
                  itemBuilder: (context, index) {
                    final feedback = controller.feedbackList[index];
                    return Container(
  margin: const EdgeInsets.symmetric(vertical: 8.0),
  padding: const EdgeInsets.all(16.0),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.grey.shade300),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 2,
        blurRadius: 6,
        offset: const Offset(0, 4),
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Title Heading
      const Text(
        "Title",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.black54,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        feedback['title'] ?? '',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 12),

      // Description Heading
      const Text(
        "Description",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.black54,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        feedback['description'] ?? '',
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade800,
        ),
      ),
      const SizedBox(height: 12),

      // Reply Heading and Text (if exists)
      if (feedback['reply'] != null) ...[
        const Text(
          "Admin Reply",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            feedback['reply'] ?? '',
            style: const TextStyle(
              color: Colors.green,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ],
  ),
);

                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
