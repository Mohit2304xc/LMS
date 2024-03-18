import 'dart:convert';

import 'package:dummy1/Model/CourseModel.dart';
import 'package:dummy1/Repository/CourseRepository.dart';
import 'package:get/get.dart';

import '../Widgets/Services/LocalStorage.dart';
import '../Widgets/snackbar/Snackbar.dart';

class FavouriteController extends GetxController {
  static FavouriteController get instance => Get.find();

  final favourites = <String, bool>{}.obs;
  final localStorage = TLocalStorage.instance();

  @override
  void onInit() {
    super.onInit();
    initFavourites();
  }

  void initFavourites() async {
    final json = localStorage.readData('favourites');
    if (json != null) {
      final storedFavourites = jsonDecode(json) as Map<String, dynamic>;
      favourites.assignAll(
          storedFavourites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String courseId) {
    return favourites[courseId] ?? false;
  }

  void saveFavouritesToStorage() {
    final encodedFavourites = json.encode(favourites);
    localStorage.saveData('favourites', encodedFavourites);
    // print(course);
  }

  void toggleFavouriteCourse(String courseId) {
    if (!favourites.containsKey(courseId)) {
      favourites[courseId] = true;
      print(courseId);
      saveFavouritesToStorage();
      SnackBars.customToast(message: 'Course has been Added to Wishlist');
    } else {
      localStorage.removeData(courseId);
      favourites.remove(courseId);
      saveFavouritesToStorage();
      favourites.refresh();
      SnackBars.customToast(message: 'Course has been Removed from Wishlist');
    }
  }

  Future<List<CourseModel>> favouriteCourses() async {
    final course = await CourseRepository.instance
        .getFavouriteCourses(favourites.keys.toList());
    print(course);
    return course;
  }
}
