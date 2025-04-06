import 'dart:io';

import 'package:digital_kabaria_app/Common/constants/constants.dart';
import 'package:digital_kabaria_app/Utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SellerProfileController extends GetxController {
  getProfile() async {
    try {
      return await firestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .get();
    } catch (e) {
      print(e.toString());
    }
  }

 RxBool isLoading = false.obs;

 Future<String> uploadImageToFirebase(File image) async {
    try {
      // Create a unique file name for the image
      String fileName =
          'profileImages/${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Get a reference to the Firebase Storage location
      Reference storageRef = FirebaseStorage.instance.ref().child(fileName);

      // Start the upload task
      UploadTask uploadTask = storageRef.putFile(image);

      // Wait for the upload to complete
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL for the uploaded image
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Return the download URL
      return downloadUrl;
    } catch (e) {
      // Handle any errors during the upload process
      print('Error uploading image to Firebase: $e');
      rethrow;
    }
  }
  updateProfile(context,{fullName,email,phone,profileImage})async{
try {
  isLoading.value =true;
  String downloadUrl = await uploadImageToFirebase(profileImage);
  var data = {
    "full_name" : fullName,
    "email_address":email,
    "phone_number":phone,
    "profileImage":downloadUrl
  };
  await firestore
          .collection("users")
          .doc(auth.currentUser!.uid).update(data);
          isLoading.value =false;
          Utils.successBar("Profile Updated SuccessFully!", context);
} catch (e) {
  isLoading.value =false;
  print(e.toString());
  
}
  }

  void updateProfilePicture(BuildContext context, File file) {}


}
