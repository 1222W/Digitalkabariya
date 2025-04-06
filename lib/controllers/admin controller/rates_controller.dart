import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RatesController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addRates(BuildContext context,
      {required String title, required String price}) async {
    try {
      await firestore.collection('rates').add({
        'title': title,
        'price': price,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Rate added successfully")),
      );
    } catch (e) {
      debugPrint("Error adding rate: $e");
    }
  }

  Stream<List<Map<String, dynamic>>> getRates() {
    return firestore.collection('rates').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data(),
        } as Map<String, dynamic>;
      }).toList();
    });
  }

  Future<void> deleteRate(String id) async {
    try {
      await firestore.collection('rates').doc(id).delete();
    } catch (e) {
      debugPrint("Error deleting rate: $e");
    }
  }
}
