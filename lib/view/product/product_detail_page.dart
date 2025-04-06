import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../../Common/custom_button.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_text.dart';
import '../../Utils/custom_navigation.dart';
import '../../controllers/product/product_detail_controller.dart';
import '../../widgets/product_widgets.dart';
import '../product/map_screen.dart';

class ProductDetailPage extends StatefulWidget {
  final String docId;
  const ProductDetailPage({super.key, required this.docId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
  final ProductDetailController controller = Get.put(ProductDetailController());
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    controller.getProductDetail(widget.docId);

    // Animation controller for transitions
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        title:  AppText(
          text: "Product Details".tr,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.whiteColor,
        ),
      ),
      body: GetBuilder<ProductDetailController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final product = controller.productModel;

          if (product == null) {
            return const Center(
              child: Text(
                'No product data available',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Product Images Slider
                const SizedBox(
                  height: 50,
                ),
                Stack(
                  children: [
                    CarouselSlider.builder(
                      itemCount: product.images.length,
                      itemBuilder: (context, index, realIdx) {
                        return Container(
                          color: Colors.black54,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              product.images[index],
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: 250,
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayCurve: Curves.easeInOut,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.5),
                        child: IconButton(
                          icon: const Icon(Icons.favorite_border,
                              color: Colors.white),
                          onPressed: () {
                            log('Favorite clicked');
                          },
                        ),
                      ),
                    )
                  ],
                ),

                // Animated Product Details
                FadeTransition(
                  opacity: _animationController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: product.name,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.appColor,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                AppText(
                                  text: "${product.price} PKR",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            AppText(
                              text: product.description,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              maxLines: 10,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                const Icon(Icons.phone_android_rounded),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: AppText(
                                    text: "Contact 1: ${product.number}".tr,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.phone_android_rounded),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: AppText(
                                    text: "Contact 2: ${product.secondNum}".tr,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                const Icon(Icons.location_on_rounded),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ProductAdrees(
                                    address: product.address,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            CustomButton(
                              btnWidth: double.infinity,
                              btnHeight: 45,
                              text: "Track Location".tr,
                              btnColor: AppColors.appColor,
                              textColor: Colors.white,
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
                            const SizedBox(height: 16),
                            if (product.voice.isNotEmpty)
                              VoiceMessageView(
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Call Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          btnHeight: 45,
                          text: "Call Number One".tr,
                          textSize: 14,
                          btnColor: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () {
                            launchUrlString("tel://${product.number}");
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomButton(
                          btnHeight: 45,
                          text: "Call Number Two".tr,
                          textSize: 14,
                          btnColor: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () {
                            launchUrlString("tel://${product.secondNum}");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
