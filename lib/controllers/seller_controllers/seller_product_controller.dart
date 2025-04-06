import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_kabaria_app/Common/constants/constants.dart';
import 'package:digital_kabaria_app/Utils/custom_navigation.dart';
import 'package:digital_kabaria_app/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerProductController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;

   Stream<List<ProductModel>> getProductData() {
    return db.collection("products").where("userId",isEqualTo: auth.currentUser!.uid).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        return ProductModel.fromJson(data, doc.id);
      }).toList();
    });
  }

  deleteProduct(docId,context)async{
    try {
      final db = FirebaseFirestore.instance;
    return await db.collection("products").doc(docId).delete().then((value){
pop(context);
    });
    } catch (e) {
     print(e.toString()); 
    }
  }
}