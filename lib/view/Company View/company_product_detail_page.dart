import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:digital_kabaria_app/Common/custom_button.dart';
import 'package:digital_kabaria_app/Utils/app_colors.dart';
import 'package:digital_kabaria_app/Utils/app_strings.dart';
import 'package:digital_kabaria_app/Utils/app_text.dart';
import 'package:digital_kabaria_app/Utils/custom_dialog.dart';
import 'package:digital_kabaria_app/Utils/custom_navigation.dart';
import 'package:digital_kabaria_app/controllers/company_controllers/company_product_detail_controller.dart';
import 'package:digital_kabaria_app/view/product/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_record/flutter_sound_record.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:voice_message_package/voice_message_package.dart';

class CompanyProductDetailPage extends StatefulWidget {
  final String docId;

  CompanyProductDetailPage({super.key, required this.docId});

  @override
  State<CompanyProductDetailPage> createState() =>
      _CompanyProductDetailPageState();
}

class _CompanyProductDetailPageState extends State<CompanyProductDetailPage> {
  final CompanyProductDetailController controller =
      Get.put(CompanyProductDetailController());
  final TextEditingController bidController = TextEditingController();
  final FlutterSoundRecord _audioRecorder = FlutterSoundRecord();

  @override
  void initState() {
    super.initState();
    controller.getProductDetail(widget.docId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.appColor,
        title: const Text(
          AppStrings.productDetail,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<CompanyProductDetailController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final product = controller.productModel;

          if (product == null) {
            return const Center(
              child: Text(
                'No product data available',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Carousel for Images
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CarouselSlider.builder(
                        itemCount: product.images.length,
                        itemBuilder: (context, index, realIdx) {
                          return Image.network(
                            product.images[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          );
                        },
                        options: CarouselOptions(
                          height: 200,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.9,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.appColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.description,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Features:'.tr,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.appColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          BulletPoint(text: "Name: ${product.name}"),
                          BulletPoint(text: "Address: ${product.address}"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Location Button
                  Center(
                    child: CustomButton(
                      btnWidth: double.infinity,
                      btnHeight: 50,
                      text: "Track Location".tr,
                      onPressed: () {
                        push(
                          context,
                          MapScreen(
                            lat: product.lat!,
                            lng: product.lng!,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Voice Message
                  if (product.voice.isNotEmpty)
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: VoiceMessageView(
                          circlesColor: AppColors.appColor,
                          activeSliderColor: AppColors.greyColor,
                          controller: VoiceController(
                            audioSrc: product.voice,
                            maxDuration: const Duration(seconds: 10),
                            isFile: false,
                            onComplete: () {},
                            onPause: () {},
                            onPlaying: () {},
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),

                  // Call Buttons
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          btnHeight: 50,
                          text: "Call Number One".tr,
                          onPressed: () {
                            launchUrlString("tel://${product.number}");
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomButton(
                          btnHeight: 50,
                          text: "Call Number Two".tr,
                          onPressed: () {
                            launchUrlString("tel://${product.secondNum}");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•', style: TextStyle(fontSize: 18)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
