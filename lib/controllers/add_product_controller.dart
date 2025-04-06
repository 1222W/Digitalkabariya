import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_kabaria_app/Common/constants/constants.dart';
import 'package:digital_kabaria_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';

class AddProductController extends GetxController {
  LatLng center = const LatLng(40.7128, -74.0060);
  PickResult? selectedPlace;
  String? address;
  String appBarTitle = 'Pick a Location';
  List<File> imgFiles = [];
  final productName = TextEditingController(text: "Ahmad");
  final productDescription = TextEditingController();
  final productNumber = TextEditingController();
  final productSecondNumber = TextEditingController();
  final productPrice = TextEditingController();
  final productNameError = RxnString(null);
  final productDescriptionError = RxnString(null);
  final productNumberError = RxnString(null);
  final productSecondNumberError = RxnString(null);
  final productPriceError = RxnString(null);
  final isLoading = false.obs;
  void setLoading(value) {
    isLoading.value = value;
  }

  void validateName(String value) {
    if (value.isEmpty) {
      productNameError.value = "Please enter product Name";
    } else {
      productNameError.value = null;
    }
  }

  void validateDescription(String value) {
    if (value.isEmpty) {
      productDescriptionError.value = "Please enter product description";
    } else {
      productDescriptionError.value = null;
    }
  }

  void validateNumber(String value) {
    if (value.isEmpty) {
      productNumberError.value = "Please enter number";
    } else if (value.length < 11) {
      productNumberError.value = "Enter a valid Phone Number";
    } else {
      productNumberError.value = null;
    }
  }

  void validateSecondNumber(String value) {
    if (value.isEmpty) {
      productSecondNumberError.value = null;
    } else if (value.length < 11) {
      productSecondNumberError.value = "Enter a valid Phone Number";
    } else {
      productSecondNumberError.value = null;
    }
  }

  void validatePrice(String value) {
    if (value.isEmpty) {
      productPriceError.value = "Please enter price";
    } else {
      productPriceError.value = null;
    }
  }

  checkValidations() {
    if (productName.text.isNotEmpty &&
        productNumber.text.isNotEmpty &&
        productPrice.text.isNotEmpty) {
      print("done");
      return true;
    } else {
      return false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  void pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    if (images == null || images.isEmpty) return;

    for (XFile image in images) {
      if (imgFiles.length >= 3) break;
      imgFiles.add(File(image.path));
    }

    update();
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      center = LatLng(position.latitude, position.longitude);
      getAddressFromLatLng(center);
    } catch (e) {
      print('Failed to get current location: $e');
    }
  }

  Future<void> getAddressFromLatLng(LatLng latLng) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        address =
            '${placemark.street}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';
        appBarTitle = address ?? 'Pick a Location';
        update();
      }
    } catch (e) {
      print('Failed to get address: $e');
    }
  }

  addProduct(
    context, {
    required List<File> imgFiles,
    required String productName,
    required String productDescription,
    required String productNumber,
    required String productSecondNumber,
    required String productPrice,
    required String address,
    required File recordedFilePath,
    final lat,
    lng,
  }) async {
    final bool check = checkValidations();
    if (check) {
      try {
        setLoading(true);
        final currentUser = FirebaseAuth.instance.currentUser!.uid;
        final db = FirebaseFirestore.instance;
        final storage = FirebaseStorage.instance;

        List<String> imageUrls = [];
        for (var imageFile in imgFiles) {
          String fileName = imageFile.path;
          String imagePath = 'images/$fileName';
          UploadTask uploadTask =
              storage.ref().child(imagePath).putFile(imageFile);
          TaskSnapshot snapshot = await uploadTask;
          String downloadUrl = await snapshot.ref.getDownloadURL();
          imageUrls.add(downloadUrl);
        }

        String voiceFileName = recordedFilePath.path;
        String voicePath = 'voice/$voiceFileName';
        UploadTask voiceUploadTask =
            storage.ref().child(voicePath).putFile(recordedFilePath);
        TaskSnapshot voiceSnapshot = await voiceUploadTask;
        String voiceDownloadUrl = await voiceSnapshot.ref.getDownloadURL();

        var data = {
          "isSold": false,
          "images": imageUrls,
          "name": productName,
          "description": productDescription,
          "number": productNumber,
          "secondNum": productSecondNumber ?? '',
          "price": productPrice,
          "address": address,
          "voice": voiceDownloadUrl,
          "lat": lat,
          "lng": lng,
          "userId": auth.currentUser!.uid,
        };
        print("dataa $data");
        clear();
        await db.collection("products").doc().set(data);
        Utils.successBar("Product Added SuccessFully!", context);
        setLoading(false);
        return '';
      } catch (e) {
        // debugger();
        setLoading(false);

        print(e);
        return e;
      }
    } else {
      Utils.flushBarErrorMessage("Enter All the Fields", context);
      return "Enter All the Field";
    }
  }

  clear() {
    productName.clear();
    productDescription.clear();
    productNumber.clear();
    productSecondNumber.clear();
    productPrice.clear();
    imgFiles.clear();
  }
}
