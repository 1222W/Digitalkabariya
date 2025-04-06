import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ShowtoastMessage {
  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: AppColors.tealColor,
        textColor: AppColors.whiteColor,
        fontSize: 14.sp);
  }

  static showErrorbar({title = "", message = "", color}) {
    return Get.snackbar(title, message,
        backgroundColor: AppColors.redColor,
        overlayColor: AppColors.redColor,
        colorText: AppColors.whiteColor);
  }

    static showSuccessbar({title = "", message = "", color}) {
    return Get.snackbar(title, message,
        backgroundColor: AppColors.greenColor,
        overlayColor: AppColors.greenColor,
        colorText: AppColors.whiteColor);
  }
}
