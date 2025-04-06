import 'package:digital_kabaria_app/common/custom_app_bar.dart';
import 'package:digital_kabaria_app/common/custom_button.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/sized_box_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/custom_text_form_field.dart';


class UserProfile extends StatefulWidget {
  final String userId;
  const UserProfile({super.key, required this.userId});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

void loadPreferences() async {
  // prefs = await SharedPreferences.getInstance();
}

class _UserProfileState extends State<UserProfile> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    // loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(flag: false),
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 1)),
          // future: FirebaseFirestore.instance
          //     .collection('users')
          //     .doc(prefs.getString('userId'))
          //     .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.appColor,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: SizedBox(
                  width: 250.w,
                  child: Text(
                    "Somethings went wrong, Check your internet connection or try again...",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.blackColor.withOpacity(50),
                        letterSpacing: 2.5,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              );
            } else if (snapshot.data != null) {
              return Center(
                child: SizedBox(
                  width: 250.w,
                  child: Text(
                    "No Account Found...",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.blackColor.withOpacity(.50),
                        letterSpacing: 2.5,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              );
            } else if (!snapshot.hasData) {
              // Map<String, dynamic> userData =
              //     snapshot.data!.data() as Map<String, dynamic>;
              return Padding(
                padding: EdgeInsets.all(15.sp),
                child: Column(
                  children: [
                    Row(
                      children: [
IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                 Navigator.pop(context);
                },
                icon: Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.appColor
                  ),
                  child: Center(
                    child: Icon(Icons.arrow_back, color: AppColors.whiteColor, size: 20.sp,),
                  ),
                ),
              ),
                      ],
                    ),
                    Container(
                  height: 100.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.blackColor.withOpacity(.15)
                  ),
                  child: Center(
                    child: Icon(CupertinoIcons.person, color: AppColors.blackColor, size: 30.sp,),
                  ),
                ),
                30.h.sizedBoxHeight,
                    const CustomTextFormField(
                        // readOnly: true,
                        
                        hintText: "Haris / Shazaib",
                        ),
                        10.h.sizedBoxHeight,
                    const CustomTextFormField(
                        // readOnly: true,
                        
                        hintText: "Organization / User / Kabariya",
                        
                        ),
                        10.h.sizedBoxHeight,

                        const CustomTextFormField(
                        // readOnly: true,
                        
                        hintText: "user@gmail.com",
                        ),
                        10.h.sizedBoxHeight,

                        const CustomTextFormField(
                        // readOnly: true,
                        
                        hintText: "03124567890",
                        ),
                        20.h.sizedBoxHeight,

                    
                    CustomButton(
                      text: "Logout",
                      onPressed: () {
                        // AuthServices().signOut(context);
                      },
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: SizedBox(
                  width: 250.w,
                  child: Text(
                    "ERROR",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.blackColor.withOpacity(.50),
                        letterSpacing: 2.5,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              );
            }
          }),
    );
  }
}
