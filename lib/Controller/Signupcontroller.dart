import 'package:dummy1/Model/Usermodel.dart';
import 'package:dummy1/Repository/AuthenticationRepository.dart';
import 'package:dummy1/Repository/UserRepository.dart';
import 'package:dummy1/Screen/VerifyEmailAddress.dart';
import 'package:dummy1/Widgets/Animation/FullScreenLoader.dart';
import 'package:dummy1/Widgets/network/NetworkManger.dart';
import 'package:dummy1/Widgets/snackbar/Snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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

      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
          email.text.trim(), password.text.trim());

      final newUser = UserModel(id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: username.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '',
      );
      
      final userRepository = Get.put(UserRepository());
      
      await userRepository.saveUserRecord(newUser);

      FullScreenLoader.stopLoading();

      SnackBars.SuccessSnackBar(title: "Congratulations",message: "Your account has been created! Verify email to continue");
      
      Get.to(()=>  VerifyEmail(email: email.text.trim()));
    } catch (e) {
      FullScreenLoader.stopLoading();

      SnackBars.ErrorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}