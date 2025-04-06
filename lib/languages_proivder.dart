import 'package:get/get.dart';

class LanguagesProvider extends GetxController {
  final selectedLanguage = 'English'.obs;
  void updateLanguage(String val) {
    selectedLanguage.value = val;
    update();
  }
}
