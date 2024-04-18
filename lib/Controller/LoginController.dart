import 'dart:convert';

import 'package:dummy1/Model/Usermodel.dart';
import 'package:dummy1/Screen/LoginScreen.dart';
import 'package:dummy1/Widgets/BottomNavigation/BottomNavigationBar.dart';
import 'package:dummy1/Widgets/Services/SharedReferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dummy1/Controller/UserController.dart';
import 'package:http/http.dart' as http;
import '../Repository/AuthenticationRepository.dart';
import '../Widgets/API_Connection/API_connection.dart';
import '../Widgets/Animation/FullScreenLoader.dart';
import '../Widgets/network/NetworkManger.dart';
import '../Widgets/snackbar/Snackbar.dart';

class LoginController extends GetxController {
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final userController = Get.put(UserController());
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }



  loginUser() async {
    try {
      FullScreenLoader.openLoadingDialog(
        "Logging you in...",
        "assets/images/success/141594-animation-of-docer.json",
      );
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }
      if (!loginFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }
      var res = await http.post(
        Uri.parse(API.login),
        body: {
          'email': email.text.trim(),
          'password': password.text.trim(),
        },
      );
      print(res);
      if (res.statusCode == 200) { // Check if res is not null
        var response = jsonDecode(res.body);
        print(response);
        if (response['success'] == true) {
          SnackBars.SuccessSnackBar(
            title: 'Congratulations',
            message: "You are logged in successfully",
          );
          UserModel userInfo = UserModel.fromJson(response["userData"]);
          UserController.instance.user.value = userInfo;
          await SharedReferences.saveUser(userInfo);
          FullScreenLoader.stopLoading();
          Get.to(()=>const NavigationMenu());
        } else {
          SnackBars.ErrorSnackBar(
            title: 'Invalid!',
            message: "Please enter correct login details or Signup",
          );
          FullScreenLoader.stopLoading();
        }
      }
    } catch (e) {
      print("${e.toString()}ho");
    }
  }


/*Future<void> emailAndPasswordSignIn() async {
    try {
      FullScreenLoader.openLoadingDialog("Logging you in...",
          "assets/images/success/141594-animation-of-docer.json");
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }
      if (!loginFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      FullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      FullScreenLoader.stopLoading();
      SnackBars.ErrorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }*/

  /*Future<void> googleSignIn() async {
    try {
      FullScreenLoader.openLoadingDialog("Logging you in...",
          "assets/images/success/141594-animation-of-docer.json");
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }
      final userCredentials =
          AuthenticationRepository.instance.signInWithGoogle();
      print(userCredentials);
      await userController.saveUserRecord(userCredentials as UserCredential);
      FullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      FullScreenLoader.stopLoading();
      SnackBars.ErrorSnackBar(title: "Oh Snap!", message: 'oh');
    }
  }*/
}
