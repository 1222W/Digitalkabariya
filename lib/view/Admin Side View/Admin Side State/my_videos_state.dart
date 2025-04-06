import 'package:get/get.dart';

class AdminState extends GetxController {
  // My Videos Select tabs
  final currentTabIndex = 0.obs;
  //
  void updateCurrenttab(int value) {
    currentTabIndex.value = value;
    update();
  }
}
