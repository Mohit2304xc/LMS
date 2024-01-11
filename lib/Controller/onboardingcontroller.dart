import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Screen/LoginScreen.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  void updatePageIndicator(index) {
    currentPageIndex.value = index;
  }

  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage() {
    if (currentPageIndex.value == 4) {
      final storage = GetStorage();

      if(kDebugMode){
        print('======================Get Storage================');
        print(storage.read('IsFirstTime'));
      }
      storage.write('IsFirstTime', false);
      if(kDebugMode){
        print('======================Get Storage================');
        print(storage.read('IsFirstTime'));
      }
      Get.offAll(()=>const LoginScreen());
    } else {
      int page = (currentPageIndex.value) + 1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage() {
    currentPageIndex.value = 4;
    pageController.jumpTo(4);
  }
}
