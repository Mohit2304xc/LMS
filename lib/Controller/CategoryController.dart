import 'package:dummy1/Model/CourseModel.dart';
import 'package:get/get.dart';
import 'package:dummy1/Model/CategoryModel.dart';
import 'package:dummy1/Repository/CategoryRepository.dart';
import 'package:dummy1/Widgets/snackbar/Snackbar.dart';

import '../Model/Usermodel.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  Rx<UserModel> user = UserModel
      .empty()
      .obs;
  final imageLoading = false.obs;
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  final RxList<CourseModel> courses = <CourseModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  final categoryRepository = Get.put(CategoryRepository());


  @override
  void onInit() {
    fetchCoursesForAllCategories();
    super.onInit();
  }


  Future<List<CourseModel>> fetchCoursesByCategory(String categoryName) async {
    try {
      isLoading.value = true;
      final categoryCourses = await categoryRepository.getCoursesByCategory(
          categoryName);
      print(categoryCourses);
      return categoryCourses;
    } catch (e) {
      SnackBars.ErrorSnackBar(title: "Oh Snap!", message: e.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  assignCourses(List<CourseModel> courses) {
    this.courses.assignAll(courses);
  }

  Future<void> fetchCoursesForAllCategories() async {
    try {
      isLoading.value = true;
      final categoryNames = await categoryRepository.getAllCategories();
      allCategories.assignAll(categoryNames);
      print(allCategories);
      for (var categoryName in categoryNames) {
        await fetchCoursesByCategory(categoryName.name);
      }
    } catch (e) {
      SnackBars.ErrorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      isLoading.value = true;
      final categoryNames = await categoryRepository.getAllCategories();
      return categoryNames;
    } catch (e) {
      SnackBars.ErrorSnackBar(title: "Oh Snap!", message: e.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }


}




