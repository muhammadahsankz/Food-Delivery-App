import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabaseMethods {
  static Future addUserDetails(Map<String, dynamic> userInfo, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userInfo);
  }

  static Future updateUserWallet(String id, String amount) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'Wallet': amount});
  }

  static Future addFoodItem(Map<String, dynamic> userInfo, String name) async {
    return await FirebaseFirestore.instance.collection(name).add(userInfo);
  }

  static Future<Stream<QuerySnapshot>> getFoodItem(String name) async {
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }
}
