import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BidsController extends GetxController {
  // product ID passed from parameter
  BidsController();

  RxList<Map<String, dynamic>> bidsList =
      <Map<String, dynamic>>[].obs; 
  RxBool isLoading = false.obs;

  RxList<Map<String, dynamic>> historyList = <Map<String, dynamic>>[].obs;

  void updateFilteredBidsList(List<Map<String, dynamic>> filteredBids) {
  
    bidsList.assignAll(filteredBids);
  }

  
  Future<void> fetchHistory(String productId) async {
    try {
      isLoading.value = true;
      historyList.clear();

      QuerySnapshot historySnapshot = await FirebaseFirestore.instance
          .collection('bids')
          .doc(productId)
          .collection('history')
          .get();

      if (historySnapshot.docs.isEmpty) {
        log('No history found for productId: $productId');
        historyList.value = [];
      } else {
        historyList.value = historySnapshot.docs.map((doc) {
          return {
            'id': doc.id, 
            'name': doc['name'] ?? '',
            'phone': doc['phone'] ?? '',
            'bidAmount': doc['bidAmount'] ?? 0,
          };
        }).toList();
      }
    } catch (e) {
      log('Error fetching history: $e');
      historyList.clear();
    } finally {
      isLoading.value = false;
    }
  }

  fetchBidsData(String productId) async {
    try {
      isLoading.value = true;
      bidsList.clear(); // Clear the previous data

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('bids')
          .doc(productId) // Navigate to the product document
          .collection('users') // Access the bids collection for this product
          .where('isAccept',
              isEqualTo: false) // Filter bids where isAccept is false
          .get();

      if (snapshot.docs.isEmpty) {
        
        bidsList.value = [];
        print('No bids found for productId: $productId');
      } else {
      
        bidsList.value = snapshot.docs.map((doc) {
          return {
            'name': doc['name'] ?? '',
            'phone': doc['phone'] ?? '',
            'price': doc['price'] ?? '',
            'isAccept': doc['isAccept'] ?? false,
          };
        }).toList();
      }
    } catch (e) {
      print('Error fetching bids: $e');
      bidsList.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
