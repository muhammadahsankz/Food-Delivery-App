import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  static getCurrentUser() async {
    return await FirebaseAuth.instance.currentUser;
  }

  static Future logoutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future deleteAccount() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }
}
