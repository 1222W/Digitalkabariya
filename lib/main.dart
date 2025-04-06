import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/utils/languages.dart';
import 'package:digital_kabaria_app/firebase_options.dart';
import 'package:digital_kabaria_app/view/Admin%20Side%20View/admin_splash_screen.dart';
import 'package:digital_kabaria_app/view/Seller%20View/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(
          MediaQuery.sizeOf(context).width, MediaQuery.sizeOf(context).height),
      child: GetMaterialApp(
        title: 'Digital Kabariya',
        translations: AppTranslations(),
        locale: const Locale('en'),
        fallbackLocale: const Locale('en'),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          fontFamily: GoogleFonts.poppinsTextTheme.toString(),
          scaffoldBackgroundColor: AppColors.whiteColor,
          useMaterial3: true,
        ),
        home: AdminSplashScreen(),
      ),
    );
  }
}

UpdateBlockField() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    final QuerySnapshot querySnapshot =
        await firestore.collection('users').get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      await firestore.collection('users').doc(doc.id).update({
        'profileImage': "",
      });
    }
    print("isBlock field added to all users successfully.");
  } catch (e) {
    print("Error updating users: $e");
  }
}
