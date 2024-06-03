import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String userIdKey = 'USERIDKEY';
  static const String userNameKey = 'USERNAMEKEY';
  static const String userEmailKey = 'USEREMAILKEY';
  static const String userWalletKey = 'USERWALLETKEY';
  static const String userProfilePicKey = 'USERPROFILEPICKEY';
  static const String foodCategoryKey = 'FOODCATEGORYKEY';

  // Methods to save User Data in Shared Preferences
  static Future<bool> setUserId(String getUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, getUserId);
  }

  static Future<bool> setUserName(String getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getUserName);
  }

  static Future<bool> setUserEmail(String getUserEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, getUserEmail);
  }

  static Future<bool> setUserWallet(double getUserWallet) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(userWalletKey, getUserWallet);
  }

  static Future<bool> setUserProfilePic(String getUserProfilePic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userProfilePicKey, getUserProfilePic);
  }

  static Future<bool> setFoodCategory(String getFoodCategory) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(foodCategoryKey, getFoodCategory);
  }

  // Methods to retrieve User Data from Shared Preferences
  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  static Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  static Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  static Future<double?> getUserWallet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(userWalletKey);
  }

  static Future<String?> getUserProfilePic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userProfilePicKey);
  }

  static Future<String?> getFoodCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(foodCategoryKey);
  }
}
