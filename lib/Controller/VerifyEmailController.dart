import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:dummy1/Repository/AuthenticationRepository.dart';
import 'package:dummy1/Screen/SuccessScreen.dart';
import 'package:dummy1/Widgets/snackbar/Snackbar.dart';


class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      SnackBars.SuccessSnackBar(
          title: "Email Sent!",
          message: "Please check your inbox and verify your email");
    } catch (e) {
      SnackBars.ErrorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  setTimerForAutoRedirect() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user?.emailVerified ?? false) {
          timer.cancel();
          Get.off(
            () => SuccessScreen(
              title: "Congratulations",
              subTitle: "Your Email has been Verified",
              image: "assets/images/success/sammy-line-success.png",
              onPressed: () {
                AuthenticationRepository.instance.screenRedirect();
              },
            ),
          );
        }
      },
    );
  }
  checkEmailVerificationStatus()async{
    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser != null && currentUser.emailVerified){
      Get.off(() => SuccessScreen(
        title: "Congratulations",
        subTitle: "Your Email has been Verified",
        image: "assets/images/success/72462-check-register.json",
        onPressed: () {
          AuthenticationRepository.instance.screenRedirect();
        },
      ));
    }
  }
}
