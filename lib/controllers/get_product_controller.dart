import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../model/product_model.dart';

class GetProductController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<List<ProductModel>> getProductData() {
    return db.collection("products").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        return ProductModel.fromJson(data, doc.id);
      }).toList();
    });
  }
}
