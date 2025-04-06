import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:digital_kabaria_app/common/app_loader.dart';
import 'package:digital_kabaria_app/common/custom_button.dart';
import 'package:digital_kabaria_app/common/custom_text_form_field.dart';
import 'package:digital_kabaria_app/controllers/seller_controllers/seller_profile_controller.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/app_text.dart';

class EditProfileScreen extends StatefulWidget {
  final String profileImage;
  final String fullName;
  final String email;
  final String phone;

  const EditProfileScreen({
    super.key,
    required this.profileImage,
    required this.fullName,
    required this.email,
    required this.phone,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final SellerProfileController controller = Get.put(SellerProfileController());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  File? selectedImage;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.fullName;
    emailController.text = widget.email;
    phoneController.text = widget.phone;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    } else {
      Get.snackbar(
        "No Image Selected",
        "Please select an image to update your profile picture.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 111, 101, 80),
        title: AppText(
          text: 'Edit Profile',
          color: AppColors.blackColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                // Profile Image
                CircleAvatar(
                  radius: 60,
                  backgroundImage: selectedImage != null
                      ? FileImage(selectedImage!) as ImageProvider
                      : NetworkImage(
                          widget.profileImage.isNotEmpty
                              ? widget.profileImage
                              : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5Bw9AT2TeVJ3fORwbFv6J1BqL9SfPXacIz_hvDkiguLtkFxkRrP5Hcw8&s',
                        ),
                ),
                IconButton(
                  onPressed: pickImage,
                  icon: const Icon(Icons.camera_alt, color: Colors.black),
                  color: AppColors.whiteColor,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Name Display
            AppText(
              text: widget.fullName.isNotEmpty ? widget.fullName : 'No Name',
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 5),

            // Email Display
            AppText(
              text: widget.email.isNotEmpty ? widget.email : 'No Email',
              fontSize: 16,
              color: Colors.grey,
            ),
            const SizedBox(height: 30),

            // Editable Fields
            CustomTextFormField(
              flag: false,
              hintText: "Full Name",
              controller: nameController,
            ),
            SizedBox(height: height * 0.02),
            CustomTextFormField(
              hintText: "Email",
              controller: emailController,
              readOnly: true, // Email should not be editable
            ),
            SizedBox(height: height * 0.02),
            CustomTextFormField(
              hintText: "Phone Number",
              controller: phoneController,
            ),
            SizedBox(height: height * 0.03),

            // Update Button
            Obx(() {
              return controller.isLoading.value
                  ? const Center(child: AppLoader())
                  : CustomButton(
                      onPressed: () {
                        // Validate fields before updating
                        if (nameController.text.isEmpty ||
                            phoneController.text.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Please fill in all fields",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return;
                        }

                        // Call update profile function
                        controller.updateProfile(
                          context,
                          fullName: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                          profileImage: selectedImage,
                        );
                      },
                      text: "Update Profile",
                      textColor: AppColors.whiteColor,
                    );
            }),
          ],
        ),
      ),
    );
  }
}
