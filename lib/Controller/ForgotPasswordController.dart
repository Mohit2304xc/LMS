import 'dart:convert';

import 'package:dummy1/Screen/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dummy1/Repository/AuthenticationRepository.dart';
import 'package:http/http.dart' as http;
import 'package:dummy1/Widgets/Animation/FullScreenLoader.dart';
import 'package:dummy1/Widgets/snackbar/Snackbar.dart';
import '../Widgets/API_Connection/API_connection.dart';
import '../Widgets/BottomNavigation/BottomNavigationBar.dart';
import '../Widgets/network/NetworkManger.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

  passwordResetDialog() async {
    try {
      FullScreenLoader.openLoadingDialog("Processing your request...",
          "assets/images/success/141594-animation-of-docer.json");
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }
      if (!forgotPasswordFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      var res = await http.post(
        Uri.parse(API.forgotPassword),
        body: {
          'email': email.text.trim(),
          'password': password.text.trim(),
        },
      );
      print(res);
      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);
        print(response);
        if (response['PasswordUpdated'] == true) {
          SnackBars.SuccessSnackBar(
              title: 'Congratulations',
              message: "Your password has been changed successfully");
          Future.delayed(
            const Duration(milliseconds: 2000),
            () {
              Get.to(()=>const LoginScreen());
            },
          );
        } else {
          SnackBars.ErrorSnackBar(
              title: 'Invalid!',
              message: "Please enter correct login details or Signup");
        }
      }
      /*await AuthenticationRepository.instance.forgotPassword(email.text.trim());
      FullScreenLoader.stopLoading();
      SnackBars.SuccessSnackBar(title: "Email Sent",message: "Email Link sent to reset your password".tr);
      Get.to(()=>ResetPassword(email:email.text.trim()));*/
    } catch (e) {
      FullScreenLoader.stopLoading();
      SnackBars.ErrorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      FullScreenLoader.openLoadingDialog("Processing your request...",
          "assets/images/success/141594-animation-of-docer.json");
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.forgotPassword(email);
      FullScreenLoader.stopLoading();
      SnackBars.SuccessSnackBar(
          title: "Email Sent",
          message: "Email Link sent to reset your password".tr);
    } catch (e) {
      FullScreenLoader.stopLoading();
      SnackBars.ErrorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}
