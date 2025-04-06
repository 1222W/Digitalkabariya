import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_kabaria_app/common/custom_button.dart';
import 'package:digital_kabaria_app/model/users.model.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/app_strings.dart';
import 'package:digital_kabaria_app/utils/app_text.dart';
import 'package:digital_kabaria_app/utils/custom_navigation.dart';
import 'package:digital_kabaria_app/utils/firebase_data.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:digital_kabaria_app/utils/utils.dart';
import 'package:digital_kabaria_app/view/Seller%20View/Auth%20View/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Company View/company_bottom_view.dart';

class RequestApprovalScreen extends StatefulWidget {
  final UsersModel usersModel;
  const RequestApprovalScreen({super.key, required this.usersModel});

  @override
  State<RequestApprovalScreen> createState() => _RequestApprovalScreenState();
}

class _RequestApprovalScreenState extends State<RequestApprovalScreen> {
  @override
  void initState() {
    checkApproval();
    super.initState();
  }

  checkApproval() {
    final id = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection(Collection.user)
        .doc(id)
        .snapshots()
        .listen((event) {
      if (event.get("is_verify") && event.get('isBlock') == false) {
        pushReplacement(
            context,
            CompanyBottomBar(
              userModel: widget.usersModel,
            ));
        Utils.successBar("Admin Approved SuccessFully!", context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppText(
                text: "Request Pending...",
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: AppColors.appColor,
              ),
              const AppText(
                textAlign: TextAlign.center,
                text:
                    "Your join request is pending approval from the admin. Please wait.",
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
              10.h.sizedBoxHeight,
              CustomButton(
                btnWidth: 150,
                text: AppStrings.goBack,
                onPressed: () {
                  pushUntil(context, const LoginView());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
