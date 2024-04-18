import 'dart:convert';

import 'package:dummy1/Model/Usermodel.dart';
import 'package:dummy1/Repository/AuthenticationRepository.dart';
import 'package:dummy1/Repository/UserRepository.dart';
import 'package:dummy1/Screen/VerifyEmailAddress.dart';
import 'package:dummy1/Widgets/Animation/FullScreenLoader.dart';
import 'package:dummy1/Widgets/network/NetworkManger.dart';
import 'package:dummy1/Widgets/snackbar/Snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Screen/LoginScreen.dart';
import '../Widgets/API_Connection/API_connection.dart';
import '../Widgets/Services/SharedReferences.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  final lastName = TextEditingController();
  final firstName = TextEditingController();
  final username = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signup() async {
    try {
      FullScreenLoader.openLoadingDialog(
          "We are processing your information...",
          "assets/images/success/141594-animation-of-docer.json");
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!signupFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!privacyPolicy.value) {
        SnackBars.WarningSnackBar(title: "Accept Privacy Policy",
            message: "In order to create account, you must have to read and accept the Privacy Policy & Terms of Use.");
        return;
      }

      validateUserEmail();
      /*final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
          email.text.trim(), password.text.trim());

      final newUser = UserModel(id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: username.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '', password: '',
      );
      
      final userRepository = Get.put(UserRepository());
      
      await userRepository.saveUserRecord(newUser);*/

      FullScreenLoader.stopLoading();

      SnackBars.SuccessSnackBar(title: "Congratulations",message: "Your account has been created! Verify email to continue");

      Get.to(()=> const LoginScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();

      SnackBars.ErrorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  validateUserEmail() async {
    try {
      var res = await http.post(
        Uri.parse(API.validateEmail),
        body: {'email': email.text.trim()},
      );
      print(res);
      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);
        print(response);
        if (response['emailFound'] == true) {
          SnackBars.WarningSnackBar(
              title: 'Email already in use', message: "Please sign in");
        } else {
          saveUserRecord();
        }
      }
    } catch (e) {
      print("${e.toString()}ho");
    }
  }

  saveUserRecord() async {
    UserModel userModel = UserModel(
      password: password.text.trim(),
      id: '',
      firstname: firstName.text.trim(),
      lastname: lastName.text.trim(),
      username: username.text.trim(),
      email: email.text.trim(),
      phonenumber: phoneNumber.text.trim(),
    );
    try {
      var res = await http.post(
          Uri.parse(API.signup),
          body: userModel.toJson());
      print(res.statusCode);
      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);
        print(response);
        if (response['success'] == true) {
          SnackBars.SuccessSnackBar(
              title: 'User data is saved successfully!');
        } else {
          SnackBars.ErrorSnackBar(
              title: 'Error', message: "Please try again later");
        }
      }
    } catch (e) {
      print("${e.toString()}oh");
    }
  }
}