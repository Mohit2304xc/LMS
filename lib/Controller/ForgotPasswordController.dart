import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dummy1/Repository/AuthenticationRepository.dart';
import 'package:dummy1/Screen/ResetPassword.dart';
import 'package:dummy1/Widgets/Animation/FullScreenLoader.dart';
import 'package:dummy1/Widgets/snackbar/Snackbar.dart';

import '../Widgets/network/NetworkManger.dart';

class ForgotPasswordController extends GetxController{
  static ForgotPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState> ();

  sendPasswordResetEmail() async{
    try{
      FullScreenLoader.openLoadingDialog("Processing your request...", "assets/images/success/141594-animation-of-docer.json");
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        FullScreenLoader.stopLoading();
        return;
      }
      if(!forgotPasswordFormKey.currentState!.validate()){

        FullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance.forgotPassword(email.text.trim());
      FullScreenLoader.stopLoading();
      SnackBars.SuccessSnackBar(title: "Email Sent",message: "Email Link sent to reset your password".tr);
      Get.to(()=>ResetPassword(email:email.text.trim()));

    } catch(e){
      FullScreenLoader.stopLoading();
      SnackBars.ErrorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async{
    try{
      FullScreenLoader.openLoadingDialog("Processing your request...", "assets/images/success/141594-animation-of-docer.json");
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        FullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.forgotPassword(email);
      FullScreenLoader.stopLoading();
      SnackBars.SuccessSnackBar(title: "Email Sent",message: "Email Link sent to reset your password".tr);

    } catch(e){
      FullScreenLoader.stopLoading();
      SnackBars.ErrorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }
}