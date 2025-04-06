import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_kabaria_app/Common/constants/constants.dart';
import 'package:digital_kabaria_app/Common/constants/enums.dart';
import 'package:digital_kabaria_app/Utils/utils.dart';
import 'package:get/get.dart';

class BidController extends GetxController {
  RxBool isLoading = false.obs;

  sendBid(
    context, {
    productId,
    productName,
    productPrice,
    productDescription,
    productImage,
    name,
    bidAmount,
  }) async {
    try {
      isLoading.value = true;
      update();
      DocumentSnapshot<Object?> userData =
          await firestore.collection("users").doc(auth.currentUser!.uid).get();
      if (!userData.exists) {
        print("user not exist");
      }

      final user = userData.data() as Map<String, dynamic>;

      var data = {
        "productName": productName,
        "productPrice": productPrice,
        "productDescription": productDescription,
        "productImage": productImage,
        "name": user["full_name"],
        "bidAmount": bidAmount,
        "productId": productId,
        "bidStatus": BIDSTATIUS.requested.name
      };
      firestore
          .collection("products")
          .doc(productId)
          .collection("bids")
          .add(data);
      isLoading.value = false;
      Utils.successBar("Bid Send SuccessFully!", context);

      update();
    } catch (e) {
      isLoading.value = false;
      update();
      print(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getBids({productId}) {
    return firestore
        .collection("products")
        .doc(productId)
        .collection("bids")
        .where("bidStatus", isEqualTo: "requested")
        .snapshots();
  }

  bidAccepted({bidId, productId}) async {
    try {
      await firestore
          .collection("products")
          .doc(productId)
          .collection("bids")
          .doc(bidId)
          .update({
        "bidStatus": BIDSTATIUS.accepted.name,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  bidRejected({bidId, productId}) async {
    try {
      await firestore
          .collection("products")
          .doc(productId)
          .collection("bids")
          .doc(bidId)
          .update({
        "bidStatus": BIDSTATIUS.cancelled.name,
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
