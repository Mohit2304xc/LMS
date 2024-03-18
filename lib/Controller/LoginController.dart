// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dummy1/Controller/UserController.dart';

import '../Repository/AuthenticationRepository.dart';
import '../Widgets/Animation/FullScreenLoader.dart';
import '../Widgets/network/NetworkManger.dart';
import '../Widgets/snackbar/Snackbar.dart';

class LoginController extends GetxController{

  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final userController = Get.put(UserController());
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState> ();

  @override
  void onInit(){
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }


  Future<void> emailAndPasswordSignIn()async{
    try{
      FullScreenLoader.openLoadingDialog("Logging you in...", "assets/images/success/141594-animation-of-docer.json");
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        FullScreenLoader.stopLoading();
        return;
      }
      if(!loginFormKey.currentState!.validate()){

        FullScreenLoader.stopLoading();
        return;
      }

      if(rememberMe.value){
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }
      await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());


      FullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();

    } catch(e){
      FullScreenLoader.stopLoading();
      SnackBars.ErrorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }


  Future<void> googleSignIn()async{
    try{
      FullScreenLoader.openLoadingDialog("Logging you in...", "assets/images/success/141594-animation-of-docer.json");
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        FullScreenLoader.stopLoading();
        return;
      }
      final userCredentials = AuthenticationRepository.instance.signInWithGoogle();
      print(userCredentials);
      await userController.saveUserRecord(userCredentials as UserCredential);
      FullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();

    } catch(e){
      FullScreenLoader.stopLoading();
      SnackBars.ErrorSnackBar(title: "Oh Snap!",message: 'oh');
    }
  }
}