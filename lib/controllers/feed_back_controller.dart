import 'package:digital_kabaria_app/Common/constants/constants.dart';
import 'package:digital_kabaria_app/Utils/utils.dart';
import 'package:get/get.dart';
class FeedBackController extends GetxController{
  RxBool isLoading = false.obs;
    RxList feedbackList = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserFeedback();
  }
   
   sendFeedback(context,{title,description}){
    try {
      isLoading.value = true;
      firestore.collection("feedback").add({
        "title":title,
        "description":description,
        "userId": auth.currentUser!.uid
        
      });
      isLoading.value = false;
      Utils.successBar("Feedback added SuccessFully!", context);

    } catch (e) {
      isLoading.value = false;
    }
   }

    Future<void> fetchUserFeedback() async {
    isLoading.value = true;
    try {
      final feedbackSnapshot = await firestore
          .collection("feedback")
          .where("userId", isEqualTo: auth.currentUser!.uid)
          .get();

      feedbackList.value = feedbackSnapshot.docs
          .map((doc) => doc.data())
          .toList();
    } catch (e) {
      // Utils.flushBarErrorMessage("Failed to load feedback",context);
    } finally {
      isLoading.value = false;
    }
  }
  
}