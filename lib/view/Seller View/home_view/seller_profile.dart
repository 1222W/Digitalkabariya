import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_kabaria_app/common/app_loader.dart';
import 'package:digital_kabaria_app/common/custom_button.dart';
import 'package:digital_kabaria_app/controllers/seller_controllers/seller_profile_controller.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/app_text.dart';
import 'package:digital_kabaria_app/utils/custom_navigation.dart';
import 'package:digital_kabaria_app/view/Seller%20View/edit_profile_screen.dart';
import 'package:digital_kabaria_app/view/Seller%20View/home_view/update_profile_view.dart';
import 'package:digital_kabaria_app/view/feed_back_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Auth View/Auth State/auth_state.dart';
import '../../all_feed_back_screens.dart';
import '../../all_feed_back_screens.dart';

class SellerProfileView extends StatefulWidget {
  const SellerProfileView({super.key});

  @override
  State<SellerProfileView> createState() => _SellerProfileViewState();
}

class _SellerProfileViewState extends State<SellerProfileView> {
  final authState = Get.put(AuthStateController());
  SellerProfileController controller = Get.put(SellerProfileController());
  var data;
  var fullName = '';
  var email = '';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: FutureBuilder(
        future: controller.getProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          }

          data = snapshot.data as DocumentSnapshot;
          fullName = data['full_name'];
          email = data['email_address'];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.05),
                  // User profile section
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          data['profileImage']?.isNotEmpty == true
                              ? data['profileImage']
                              : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5Bw9AT2TeVJ3fORwbFv6J1BqL9SfPXacIz_hvDkiguLtkFxkRrP5Hcw8&s',
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: fullName,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 5),
                          AppText(
                            text: email,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.05),

                  _buildFeatureTile(
                    context,
                    icon: Icons.edit,
                    title: 'Edit Profile'.tr,
                    subtitle: 'Edit and update your profile information'.tr,
                    onTap: () => push(
                        context,
                        EditProfileScreen(
                          profileImage: data['profileImage'],
                          fullName: fullName,
                          email: email,
                          phone: data['phone_number'],
                        )),
                  ),
                  _buildFeatureTile(
                    context,
                    icon: Icons.feedback,
                    title: 'Send Feedback to admin'.tr,
                    subtitle: 'Share your feedback with us'.tr,
                    onTap: () => push(context, const FeedbackScreen()),
                  ),
                  _buildFeatureTile(
                    context,
                    icon: Icons.reply,
                    title: 'View admin Reply'.tr,
                    subtitle: 'Check replies to your feedback'.tr,
                    onTap: () => push(context, const AllFeedBackScreens()),
                  ),
                  _buildFeatureTile(
                    context,
                    icon: Icons.logout,
                    title: 'Logout'.tr,
                    subtitle: 'Sign out of your account'.tr,
                    onTap: () => authState.logOut(context),
                    tileColor: AppColors.redColor,
                    iconColor: Colors.white,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper method to build a feature tile
  Widget _buildFeatureTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color tileColor = Colors.white,
    Color iconColor = AppColors.blackColor,
    Color textColor = Colors.black,
  }) {
    return Card(
      color: tileColor,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: iconColor, size: 30),
        title: Text(
          title,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: textColor.withOpacity(0.6)),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}
