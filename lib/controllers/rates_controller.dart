import 'package:digital_kabaria_app/Common/constants/constants.dart';
import 'package:digital_kabaria_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatesController extends GetxController {
  addRates(context, {title, price}) async {
    var data = {
      "title": title,
      "price": price,
    };
    try {
      await firestore.collection('rates').add(data);
      Utils.successBar("Rate Added SuccessFully", context);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> editRates(BuildContext context, String id,
      {String? title, String? price}) async {
    var data = {
      if (title != null) "title": title,
      if (price != null) "price": price,
    };

    try {
      // Update the specific document in Firestore
      await firestore.collection('rates').doc(id).update(data);
      Utils.successBar("Rate Updated Successfully", context);
    } catch (e) {
      print(e.toString());
      Utils.flushBarErrorMessage("Failed to update rate", context);
    }
  }

  // Get rates as a stream
  Stream<List<Map<String, dynamic>>> getRates() {
    return firestore.collection('rates').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'id': doc.id, // Document ID for delete/edit operations
          ...doc.data(),
        } as Map<String, dynamic>;
      }).toList();
    });
  }

  // Delete a rate by document ID
  Future<void> deleteRate(String id) async {
    try {
      await firestore.collection('rates').doc(id).delete();
    } catch (e) {
      debugPrint("Error deleting rate: $e");
    }
  }
}
