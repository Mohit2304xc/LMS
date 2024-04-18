import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dummy1/Repository/UserRepository.dart';
import 'package:dummy1/Widgets/Animation/FullScreenLoader.dart';
import 'package:dummy1/Widgets/Setting/ProfileScreen.dart';
import 'package:dummy1/Widgets/network/NetworkManger.dart';
import 'package:dummy1/Widgets/snackbar/Snackbar.dart';

import '../Widgets/API_Connection/API_connection.dart';
import 'UserController.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());

  final existingEmailFormKey = GlobalKey<FormState>();
  final newEmailFormKey = GlobalKey<FormState>();
  final firstNameFormKey = GlobalKey<FormState>();
  final lastNameFormKey = GlobalKey<FormState>();
  final usernameFormKey = GlobalKey<FormState>();
  final phoneNumberFormKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final existingEmailController = TextEditingController();
  final newEmailController = TextEditingController();

  /*Future<void> initializeNames()async{
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
    username.text = userController.user.value.username;
    email.text = userController.user.value.email;
    phoneNumber.text = userController.user.value.phoneNumber;
  }*/

  Future<void> updateUserName() async {
    try {
      FullScreenLoader.openLoadingDialog("We are updating your information",
          "assets/images/success/141594-animation-of-docer.json");
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }
      if (!firstNameFormKey.currentState!.validate() &
          !lastNameFormKey.currentState!.validate() &
          !newEmailFormKey.currentState!.validate() &
          !usernameFormKey.currentState!.validate() &
          !phoneNumberFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }
      var res = await http.post(
        Uri.parse(API.updateName),
        body: {
          'existingemail': existingEmailController.text.trim(),
          'newemail': newEmailController.text.trim(),
          'firstname': firstNameController.text.trim(),
          'lastname': lastNameController.text.trim(),
          'username': usernameController.text.trim(),
          'phonenumber': phoneNumberController.text.trim()
        },
      );
      print(res);
      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);
        print(response);
        if (response['dataUpdated'] == true) {
          FullScreenLoader.stopLoading();
          SnackBars.SuccessSnackBar(
              title: "Congratulation", message: "Your Name has been updated");
          Get.off(() => const ProfileScreen());
        } else {
          SnackBars.ErrorSnackBar(
              title: "Oh Snap!", message: "Please enter valid details");
        }
      }
      /*Map<String,dynamic> name = {'FirstName': firstName.text.trim(),'LastName':lastName.text.trim()};
      await userRepository.updateSingleField(name);
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();*/
    } catch (e) {
      FullScreenLoader.stopLoading();
      SnackBars.ErrorSnackBar(title: "Oh snap!", message: e.toString());
    }
  }
}
