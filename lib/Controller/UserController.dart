import 'package:dummy1/Widgets/reAuthenticate_user_login_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dummy1/Repository/AuthenticationRepository.dart';
import 'package:dummy1/Repository/UserRepository.dart';
import 'package:dummy1/Screen/LoginScreen.dart';
import 'package:dummy1/Widgets/Animation/FullScreenLoader.dart';
import 'package:dummy1/Model/Usermodel.dart';
import 'package:dummy1/Widgets/snackbar/Snackbar.dart';
import '../Widgets/Services/SharedReferences.dart';
import '../Widgets/network/NetworkManger.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());
  final profileLoading = false.obs;
  final imageLoading = false.obs;
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();

  @override
  void onInit() {
    getUserInfo();
    super.onInit();
  }

  getUserInfo() async {
    try {
      profileLoading.value = true;
      UserModel? getUserInfoFromLocalStorage =
          await SharedReferences.readUser();
      user.value = getUserInfoFromLocalStorage!;
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /*Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      //final user = await userRepository.fetchUserDetails();
      //this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }
*/
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(16),
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete your account permanently?',
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            side: const BorderSide(color: Colors.red)),
        onPressed: () async => deleteUserAccount(),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }

  void deleteUserAccount() async {
    try {
      FullScreenLoader.openLoadingDialog(
          "Processing", "assets/images/success/141594-animation-of-docer.json");
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          FullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          FullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      SnackBars.ErrorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      FullScreenLoader.openLoadingDialog("Processing...",
          "assets/images/success/141594-animation-of-docer.json");
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }
      if (!reAuthFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());

      FullScreenLoader.stopLoading();
      Get.to(() => const LoginScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();
      SnackBars.ErrorSnackBar(title: "Oh snap!", message: e.toString());
    }
  }

  /*Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      //refresh user record
      await fetchUserRecord();
      //if no user record
      if(user.value.id.isEmpty) {
        if (userCredential != null)  {
          final nameParts = UserModel.nameParts(
              userCredential.user!.displayName ?? '');
          final username = UserModel.generateUserName(
              userCredential.user!.displayName ?? '');
          final user = UserModel(id: userCredential.user!.uid,
              firstName: nameParts[0],
              lastName: nameParts.length > 1
                  ? nameParts.sublist(1).join(' ')
                  : '',
              username: username,
              email: userCredential.user!.email ?? '',
              phoneNumber: userCredential.user!.phoneNumber ?? '',
              profilePicture: userCredential.user!.photoURL ?? '', password: ''
          );
          //await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      SnackBars.ErrorSnackBar(title: "Data not saved");
    }
  }*/

  ///upload profile picture
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        imageLoading.value = true;
        final imageUrl =
            await userRepository.uploadImage('Users/Images/Profile/', image);
        //update user image record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        //Reference reference = FirebaseStorage.instance.ref().child("Photos/");
        //UploadTask uploadTask = reference.putFile(File(imageUrl));
        ///await userRepository.updateSingleField(json);
        user.value.profilePicture = imageUrl;
        user.refresh();
        SnackBars.SuccessSnackBar(
            title: "Congratulations!",
            message: "Your profile Image is updated successfully");
      }
    } catch (e) {
      SnackBars.ErrorSnackBar(title: "Oh", message: "Something went wrong:$e");
    } finally {
      imageLoading.value = false;
    }
  }
}
