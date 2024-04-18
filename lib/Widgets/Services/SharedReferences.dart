import 'dart:convert';
import 'package:dummy1/Model/Usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedReferences {
  static Future<void> saveUser(UserModel userInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(userInfo);
    String userJsonData = jsonEncode(userInfo.toJson());
    await preferences.setString("currentUser", userJsonData);
  }

  static Future<void> saveDataInWishlist(String key,String course) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, course);
  }

  static Future<String?> readDataFromWishlist(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final data = preferences.getString(key);
    return data;
  }

  static Future<void> removeData(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(key);
  }

  static Future<UserModel?> readUser() async {
    UserModel? currentUserInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userInfo = preferences.getString("currentUser");

    if(userInfo != null){
      Map<String,dynamic> userData = jsonDecode(userInfo);
      currentUserInfo = UserModel.fromJson(userData);
    }
    return currentUserInfo;
  }
}