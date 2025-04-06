import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_kabaria_app/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyHomeController extends GetxController {
    final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<List<ProductModel>> getProductData() {
    return db.collection("collector_products").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        return ProductModel.fromJson(data, doc.id);
      }).toList();
    });
  }
  
}