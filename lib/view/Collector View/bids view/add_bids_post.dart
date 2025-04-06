import 'dart:developer';
import 'dart:io';

import 'package:digital_kabaria_app/Common/custom_dropdown.dart';
import 'package:digital_kabaria_app/common/add_product_widget/add_product_widgets.dart';
import 'package:digital_kabaria_app/common/app_loader.dart';
import 'package:digital_kabaria_app/common/custom_app_bar.dart';
import 'package:digital_kabaria_app/common/custom_button.dart';
import 'package:digital_kabaria_app/common/custom_check_box.dart';
import 'package:digital_kabaria_app/common/custom_text_form_field.dart';
import 'package:digital_kabaria_app/controllers/add_product_controller.dart';
import 'package:digital_kabaria_app/controllers/collector_controllers/collector_product_controller.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/app_strings.dart';
import 'package:digital_kabaria_app/utils/app_text.dart';
import 'package:digital_kabaria_app/utils/custom_navigation.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:digital_kabaria_app/view/Seller%20View/location/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_sound_record/flutter_sound_record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:voice_message_package/voice_message_package.dart';
import 'package:audioplayers/audioplayers.dart';

class AddPostBidScreen extends StatefulWidget {
  const AddPostBidScreen({super.key});

  @override
  State<AddPostBidScreen> createState() => _AddPostBidScreenState();
}

class _AddPostBidScreenState extends State<AddPostBidScreen> {
  bool _isSellChecked = false;
  bool _isAlertChecked = false;

  final FlutterSoundRecord _audioRecorder = FlutterSoundRecord();
  bool _isRecording = false;
  String _recordedFilePath = '';
  bool _hasRecordedFile = false;
  final formKey = GlobalKey<FormState>();
  final productListName = [
  
    "Plastic",
    "Metal",
    "Wood",
    "Paper",
    "Fabric",
    "Machinery"
  ];

  final TextEditingController _bidController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    _bidController.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    if (await _checkPermissions()) {
      Directory tempDir = await getTemporaryDirectory();
      String path = '${tempDir.path}/voice_record.aac';
      await _audioRecorder.start(path: path);
      setState(() {
        _isRecording = true;
        _recordedFilePath = path;
      });
    } else {
      print('Permissions not granted');
    }
  }

  Future<void> _stopRecording() async {
    await _audioRecorder.stop();
    setState(() {
      _isRecording = false;
      _hasRecordedFile = true;
    });
  }

  deleteVoice() async {
    await _audioRecorder.stop();
    setState(() {
      _recordedFilePath = "";
      _hasRecordedFile = false;
    });
  }

  Future<bool> _checkPermissions() async {
    var status = await Permission.microphone.status;
    if (status.isDenied) {
      status = await Permission.microphone.request();
    }
    return status.isGranted;
  }

  void _playRecording() async {
    final player = AudioPlayer();
    await player.play(DeviceFileSource(_recordedFilePath));
  }

  CollectorProductController controller = Get.put(CollectorProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        flag: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.h.sizedBoxHeight,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: GetBuilder<CollectorProductController>(
                    builder: (controller) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          controller.imgFiles.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: ProductImageContainer(
                              backgroundImage: controller.imgFiles[index] !=
                                      null
                                  ? FileImage(
                                      File(controller.imgFiles[index].path))
                                  : const AssetImage("assets/images/home.png")
                                      as ImageProvider,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                20.h.sizedBoxHeight,
                CustomButton(
                  btnWidth: 130,
                  btnHeight: 40,
                  text: "Pick Image".tr,
                  onPressed: () {
                    controller.pickImages();
                  },
                ),
                20.h.sizedBoxHeight,
                GetBuilder<CollectorProductController>(builder: (controller) {
                  return CustomDropdownWidget(
                    controller: controller.productName,
                    items: productListName,
                    hintText: "Select Scrap Type".tr,
                  );
                }),
                20.h.sizedBoxHeight,
                GetBuilder<CollectorProductController>(builder: (controller) {
                  return CustomTextFormField(
                    controller: controller.productDescription,
                    validator: (value) {
                      controller.validateDescription(value!);
                      return controller.productDescriptionError.value;
                    },
                    maxLines: 2,
                    hintText: "Product Description".tr,
                    flag: true,
                  );
                }),
                20.h.sizedBoxHeight,
                CustomTextFormField(
                  controller: controller.productPrice,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter product price";
                    }
                    return null;
                  },
                  hintText: "Product Price".tr,
                  keyboardType: TextInputType.number,
                  flag: true,
                ),
                20.h.sizedBoxHeight,
                CustomTextFormField(
                  controller: _bidController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter bid amount";
                    }
                    if (double.parse(value) >
                        double.parse(controller.productPrice.text)) {
                      return "Bid amount cannot exceed product price";
                    }
                    return null;
                  },
                  hintText: "Enter your bid".tr,
                  keyboardType: TextInputType.number,
                  flag: true,
                ),
                20.h.sizedBoxHeight,
                CustomButton(
                  btnWidth: 150,
                  text: "Pick Location".tr,
                  onPressed: () {
                    push(context, const LocationScreen());
                  },
                ),
                10.h.sizedBoxHeight,
                const AppText(text: "Selected Address"),
                GetBuilder<CollectorProductController>(builder: (controller) {
                  if (controller.address == null) {
                    return const SizedBox();
                  } else {
                    return AppText(text: controller.address.toString());
                  }
                }),
                20.h.sizedBoxHeight,
               if (_hasRecordedFile)
                  Row(
                    children: [
                      VoiceMessageView(
                        circlesColor: AppColors.appColor,
                        activeSliderColor: AppColors.greyColor,
                        controller: VoiceController(
                          audioSrc: _recordedFilePath,
                          maxDuration: const Duration(minutes: 1000),
                          isFile: true,
                          onComplete: () {
                            print('Recording complete');
                          },
                          onPause: () {
                            print('Playback paused');
                          },
                          onPlaying: () {
                            print('Playback started');
                          },
                          onError: (err) {
                            print('Voice recording error: $err');
                          },
                        ),
                        innerPadding: 12,
                        cornerRadius: 20,
                      ),
                      InkWell(
                          onTap: () {
                            deleteVoice();
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ],
                  ),
                20.h.sizedBoxHeight,
                CustomButton(
                  btnWidth: 140,
                  text: _isRecording ? "Stop Recording" : "Record Voice".tr,
                  onPressed: _isRecording ? _stopRecording : _startRecording,
                ),
                50.h.sizedBoxHeight,
                Obx(() {
                  return controller.isLoading.value
                      ? const Center(child: AppLoader())
                      : CustomButton(
                          text: AppStrings.submit.tr,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              controller.addProduct(context,
                                  imgFiles: controller.imgFiles,
                                  productName: controller.productName.text,
                                  productDescription:
                                      controller.productDescription.text,
                                  productNumber: controller.productNumber.text,
                                  productSecondNumber:
                                      controller.productSecondNumber.text,
                                  productPrice: controller.productPrice.text,
                                  address: controller.address.toString(),
                                  recordedFilePath: File(_recordedFilePath),
                                  bidAmount: _bidController.text,
                                  lat: controller.center.latitude,
                                  lng: controller.center.longitude);
                            }
                          },
                        );
                }),
                20.h.sizedBoxHeight,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
