import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_kabaria_app/utils/firebase_data.dart';
import 'package:get/get.dart';

class UsersController extends GetxController {
  final db = FirebaseFirestore.instance;
  getUsersData() {
    try {
      return db.collection(Collection.user).snapshots();
    } catch (e) {
      print(e.toString());
    }
  }

  getAgencyData() {
    try {
      return db
          .collection(Collection.user)
          .where("is_verify", isEqualTo: false)
          .snapshots();
    } catch (e) {
      print(e.toString());
    }
  }

  updateValue({id, key, value}) async {
    try {
      await db.collection(Collection.user).doc(id).update({key: value});
    } catch (e) {
      print(e.toString());
    }
  }
}
