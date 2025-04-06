import 'package:get/get.dart';

class CompanyState extends GetxController {
  
  // User Home Bottom Nav State
final currentIndex = 0.obs;
//
void updateSelectedIndex(int value) {
    // Ensure the index is within the bounds of the available pages
    if (value >= 0 && value < 2) { // Assuming you have 2 pages in your navigation
      currentIndex.value = value;
    }
  }
}