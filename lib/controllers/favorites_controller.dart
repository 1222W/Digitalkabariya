import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:digital_kabaria_app/model/product_model.dart';

class FavoritesController extends GetxController {
  var isLoading = true.obs;
  var favorites = <ProductModel>[].obs;

  void fetchFavorites(String userId) async {
    try {
      isLoading(true);

      // Fetch favorites from Firestore
      var querySnapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .doc(userId)
          .collection('likes')
          .get();

      // Map the documents to ProductModel
      favorites.value = querySnapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print("Error fetching favorites: $e");
    } finally {
      isLoading(false);
    }
  }

  void deleteFavorite(String userId, String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('favorites')
          .doc(userId)
          .collection('likes')
          .doc(docId)
          .delete();

      // Update the local list of favorites
      favorites.removeWhere((product) => product.docId == docId);

      Get.snackbar("Success", "Favorite item deleted successfully",
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", "Failed to delete favorite item",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
