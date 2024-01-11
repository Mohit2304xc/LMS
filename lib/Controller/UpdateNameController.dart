
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dummy1/Repository/UserRepository.dart';
import 'package:dummy1/Widgets/Animation/FullScreenLoader.dart';
import 'package:dummy1/Widgets/Setting/ProfileScreen.dart';
import 'package:dummy1/Widgets/network/NetworkManger.dart';
import 'package:dummy1/Widgets/snackbar/Snackbar.dart';

import 'UserController.dart';

class UpdateNameController extends GetxController{
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState> ();

  @override
  void onInit(){
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames()async{
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName()async{
    try{
      FullScreenLoader.openLoadingDialog("We are updating your information", "assets/images/success/141594-animation-of-docer.json");
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        FullScreenLoader.stopLoading();
        return;
      }
      if(!updateUserNameFormKey.currentState!.validate()){
        FullScreenLoader.stopLoading();
        return;
      }
      Map<String,dynamic> name = {'FirstName': firstName.text.trim(),'LastName':lastName.text.trim()};
      await userRepository.updateSingleField(name);
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      FullScreenLoader.stopLoading();
      SnackBars.SuccessSnackBar(title: "Congratulation",message: "Your Name has been updated");
      Get.off(()=>const ProfileScreen());
    } catch(e){
      FullScreenLoader.stopLoading();
      SnackBars.ErrorSnackBar(title: "Oh snap!",message: e.toString());
    }
  }
}