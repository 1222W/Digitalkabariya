import 'package:digital_kabaria_app/utils/custom_navigation.dart';
import 'package:digital_kabaria_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  var isLoading = false.obs;
  setLoading(bool Loading){
   isLoading.value = Loading;
  }
  final firebaseAuth = FirebaseAuth.instance;

  resetPassword(context,{required String email}) async {
  try {
    setLoading(true);
      await firebaseAuth.sendPasswordResetEmail(email: email);
      setLoading(false);
      pop(context);
      Utils.successBar("Please check your Gmail for the password reset link", context);
  } catch (e) {
      setLoading(false);
      Utils.flushBarErrorMessage(e.toString(),context);
    
    print(e.toString());
  }
  }
}
