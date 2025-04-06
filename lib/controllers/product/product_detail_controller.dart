import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_kabaria_app/Common/constants/constants.dart';
import 'package:digital_kabaria_app/model/product_model.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ProductModel? _productModel;
  ProductModel? get productModel => _productModel;

  Future<void> getProductDetail(String docId) async {
    try {
      _isLoading = true;
      update();

      var docSnapshot = await FirebaseFirestore.instance
          .collection('products')
          .doc(docId)
          .get();

      if (docSnapshot.exists) {
        var data = docSnapshot.data();
        _productModel = ProductModel.fromJson(data!, docId);
      } else {
        print("Document does not exist");
        _productModel = null;
      }
    } catch (e) {
      print(e.toString());
      _productModel = null;
    } finally {
      _isLoading = false;
      update();
    }
  }

  Stream<QuerySnapshot>? getProductData() {
    try {
      return firestore.collection("products").snapshots();
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
