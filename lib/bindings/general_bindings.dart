import 'package:dummy1/Controller/AddressController.dart';
import 'package:dummy1/Controller/CartController.dart';
import 'package:dummy1/Controller/CheckoutController.dart';
import 'package:dummy1/Controller/FavouriteController.dart';
import 'package:dummy1/Repository/CourseRepository.dart';
import 'package:dummy1/Widgets/Services/LocalStorage.dart';
import 'package:get/get.dart';
import 'package:dummy1/Widgets/network/NetworkManger.dart';

import '../Controller/BannerController.dart';
import '../Controller/Course/CourseImagesController.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(NetworkManager());
    Get.put(AddressController());
    Get.put(CheckoutController());
    Get.put(CourseRepository());
  }

}