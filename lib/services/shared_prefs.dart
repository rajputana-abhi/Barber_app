import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrences {
  String userIdkey = "USERIDKEY";
  String userNamekey = "USERNAMEKEY";
  String userEmailkey = "USEREMAILKEY";
  String userImagekey = "USERIMAGEKEY";

  Future<bool> saveUserId(String getUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdkey, getUserId);
  }

  Future<bool> saveUserName(String getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNamekey, getUserName);
  }

  Future<bool> saveUserEmail(String getUserEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailkey, getUserEmail);
  }

  Future<bool> saveUserImages(String getUserImages) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userImagekey, getUserImages);
  }

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNamekey);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailkey);
  }

  Future<String?> getUserid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdkey);
  }

  Future<String?> getUserImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userImagekey);
  }
}
