import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:digital_kabaria_app/Common/custom_dropdown.dart';
import 'package:digital_kabaria_app/Utils/utils.dart';
import 'package:digital_kabaria_app/common/add_product_widget/add_product_widgets.dart';
import 'package:digital_kabaria_app/common/app_loader.dart';
import 'package:digital_kabaria_app/common/custom_app_bar.dart';
import 'package:digital_kabaria_app/common/custom_button.dart';
import 'package:digital_kabaria_app/common/custom_check_box.dart';
import 'package:digital_kabaria_app/common/custom_text_form_field.dart';
import 'package:digital_kabaria_app/controllers/add_product_controller.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/app_strings.dart';
import 'package:digital_kabaria_app/utils/app_text.dart';
import 'package:digital_kabaria_app/utils/custom_navigation.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:digital_kabaria_app/view/Seller%20View/home_view/seller_home_view.dart';
import 'package:digital_kabaria_app/view/Seller%20View/location/location_screen.dart';
import 'package:digital_kabaria_app/view/Seller%20View/posted_materials_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_sound_record/flutter_sound_record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:voice_message_package/voice_message_package.dart';
import 'package:audioplayers/audioplayers.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool _isSellChecked = false;
  bool _isAlertChecked = false;

  final FlutterSoundRecord _audioRecorder = FlutterSoundRecord();
  bool _isRecording = false;
  String _recordedFilePath = '';
  bool _hasRecordedFile = false;
  final formKey = GlobalKey<FormState>();
  bool _isTimerActive = false; // Variable to control timer
  int _elapsedTime = 0; // Counter for elapsed time
  Timer? _timer;

  void _startTimer() {
    // If the timer is already running, cancel it first
    _timer?.cancel();

    // Reset the elapsed time
    setState(() {
      _elapsedTime = 0;
    });

    // Start a new timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime++;
      });
    });

    setState(() {
      _isTimerActive = true;
    });
  }

  void _stopTimer() {
    // Stop and reset the timer
    _timer?.cancel();
    setState(() {
      _isTimerActive = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initFunction();
    _checkPermissions();
  }

  @override
  void dispose() {
    _timer!.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  initFunction() {
    controller.productSecondNumber.clear();
    controller.productNumber.clear();
    controller.imgFiles.clear();
    setState(() {
      controller.productName.clear();
      controller.productPrice.clear();
    });
  }

  Future<void> _startRecording() async {
    if (await _checkPermissions()) {
      Directory tempDir = await getTemporaryDirectory();
      String path = '${tempDir.path}/voice_record.aac';
      _startTimer();
      await _audioRecorder.start(path: path);
      setState(() {
        _isRecording = true;
        _recordedFilePath = path;
      });
    } else {
      _stopTimer();
      print('Permissions not granted');
    }
  }

  Future<void> _stopRecording() async {
    _stopTimer();
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
    // if (result == 1) {
    //   // success
    //   print('Playback started');
    // } else {
    //   // failure
    //   print('Error during playback');
    // }
  }

  void _onChanged(bool? newValue) {
    setState(() {
      _isSellChecked = newValue ?? false;
      _isAlertChecked = newValue ?? false;
    });
  }

  AddProductController controller = Get.put(AddProductController());

  final productListName = [
    "Plastic".tr,
    "Metal".tr,
    "Wood".tr,
    "Paper".tr,
    "Fabric".tr,
    "Machinery".tr
  ];

  final priceRange = [
    "0 - 500",
    "500 - 1000",
    "1000 - 2000",
    "2000 - 3000",
    "3000 - 4000",
    "4000 - 5000"
  ];

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
                  child: GetBuilder<AddProductController>(
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
             
                GetBuilder<AddProductController>(builder: (controller) {
                  return CustomDropdownWidget(
                    items: productListName,
                    controller: controller.productName,
                    hintText: "Select Scrap Type".tr,
                  );
                }),
               
                20.h.sizedBoxHeight,
                GetBuilder<AddProductController>(builder: (controller) {
                  return CustomTextFormField(
                    controller: controller.productNumber,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      controller.validateNumber(value!);
                      return controller.productNumberError.value;
                    },
                    hintText: "Phone Number".tr,
                    flag: true,
                  );
                }),
                20.h.sizedBoxHeight,
                GetBuilder<AddProductController>(builder: (controller) {
                  return CustomTextFormField(
                    keyboardType: TextInputType.number,
                    controller: controller.productSecondNumber,
                    validator: (value) {
                      controller.validateSecondNumber(value!);
                      return controller.productSecondNumberError.value;
                    },
                    hintText: "Second Phone Number (Optional)".tr,
                    flag: true,
                  );
                }),
                20.h.sizedBoxHeight,

                /// changes required
                GetBuilder<AddProductController>(builder: (controller) {
                  return CustomDropdownWidget(
                    items: priceRange,
                    controller: controller.productPrice,
                    hintText: "Select Price Range",
                    onItemSelected: (value) {
                      controller.productPrice.text = value;
                    },
                  );
                }),
                20.h.sizedBoxHeight,
                CustomButton(
                  btnWidth: 150,
                  text: "Pick Location".tr,
                  onPressed: () {
                    push(context, const LocationScreen());
                  },
                ),
                10.h.sizedBoxHeight,
                const AppText(text: "Selected Address "),

                GetBuilder<AddProductController>(builder: (controller) {
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
                          maxDuration: const Duration(seconds: 10),
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

                Row(
                  children: [
                    CustomButton(
                      btnWidth: 140,
                      text: _isRecording ? "Stop Recording" : "Record Voice".tr,
                      onPressed:
                          _isRecording ? _stopRecording : _startRecording,
                    ),
                    if (_isRecording) ...[
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '$_elapsedTime seconds',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ]
                  ],
                ),
                20.h.sizedBoxHeight,
                Obx(() {
                  return controller.isLoading.value
                      ? const Center(child: AppLoader())
                      : CustomButton(
                          text: AppStrings.submit.tr,
                          onPressed: () async {
                            var data = {
                              "images": controller.imgFiles.first,
                              "name": controller.productName.text,
                              "descrption": controller.productDescription.text,
                              "number": controller.productNumber.text,
                              "secondNum": controller.productSecondNumber.text,
                              "price": controller.productPrice.text,
                              "address": controller.address,
                              "voice": _recordedFilePath,
                              "lat": controller.center.latitude,
                              "lng": controller.center.longitude,
                            };
                            if (formKey.currentState!.validate()) {
                              final String response =
                                  await controller.addProduct(context,
                                      imgFiles: controller.imgFiles,
                                      productName: controller.productName.text,
                                      productDescription:
                                          controller.productDescription.text,
                                      productNumber:
                                          controller.productNumber.text,
                                      productSecondNumber:
                                          controller.productSecondNumber.text,
                                      productPrice:
                                          controller.productPrice.text,
                                      address: controller.address.toString(),
                                      recordedFilePath: File(_recordedFilePath),
                                      lat: controller.center.latitude,
                                      lng: controller.center.longitude);
                              if (response.isEmpty) {
                             
                                pushUntil(context, SellerHomeView());
                              } else {
                                Utils.flushBarErrorMessage(
                                    "Enter All the Fields", context);
                              }
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
