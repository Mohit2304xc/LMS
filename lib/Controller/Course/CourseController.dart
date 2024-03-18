import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy1/Model/CourseModel.dart';
import 'package:dummy1/Widgets/snackbar/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Repository/CourseRepository.dart';

class CourseController extends GetxController {
  static CourseController get instance => Get.find();

  RxList<CourseModel> popularProducts = <CourseModel>[].obs;
  RxList<CourseModel> searchProducts = <CourseModel>[].obs;
  RxList<CourseModel> allProducts = <CourseModel>[].obs;
  final isLoading = false.obs;
  final title = Get.put(TextEditingController());
  final RxList<CourseModel> courses = <CourseModel>[].obs;
  final courseRepository = CourseRepository.instance;

  @override
  void onInit() {
    fetchPopularProducts();
    fetchAllPopularProducts();
    super.onInit();
  }

  Future<CourseModel?> findCourseByName(String name) async {
    final courses = await fetchAllPopularProducts();
    final matchingCourse = courses.firstWhere((course) => course.title == name, orElse: () => null as CourseModel);
    return matchingCourse;
  }




  void assignCourses(List<CourseModel> courses) {
    this.courses.assignAll(courses);
  }

  Future<List<CourseModel>> fetchCoursesByQuery(Query? query) async {
    try {
      if (query == null) {
        return [];
      }
      final courses = await courseRepository.fetchCoursesByQuery(query);
      return courses;
    } catch (e) {
      SnackBars.ErrorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void searchCourses(String query) async {
    searchProducts.value = await courseRepository.searchCourses(query);
  }

  void inputTitleForDocumentUploadPopup() {
    Get.dialog(
      AlertDialog(
        title: const Text('Title'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: title,
              decoration: const InputDecoration(labelText: 'Enter Title'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Retrieve data when the button is pressed
                String data = Get.find<TextEditingController>().text;
                courseRepository.pickFile(data);
                Get.back(); // Pass the data as a result
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onClose() {
    // Dispose of the TextEditingController when no longer needed
    title.dispose();
    super.onClose();
  }

  Future<List<CourseModel>> fetchPopularProducts() async {
    try {
      final response = await http.get(Uri.parse(
          'https://lms.prabisha.com/wp-json/wc/v3/products?per_page=100&consumer_key=ck_a57db437f1c9d5273d73fe76d0beac292e85d0aa&consumer_secret=cs_0e2c4571b4035f97cdac6693c71b082b79fe52a4'));

      if (response.statusCode == 200) {
        List<dynamic> allProducts = json.decode(response.body);
        List<CourseModel> courses = allProducts.take(4).map((e) => CourseModel.fromJson(e)).toList();
        popularProducts.assignAll(courses);
        return popularProducts;
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }



  Future<List<CourseModel>> fetchAllPopularProducts() async {
    try {
      final response = await http.get(Uri.parse(
          'https://lms.prabisha.com/wp-json/wc/v3/products?per_page=100&consumer_key=ck_a57db437f1c9d5273d73fe76d0beac292e85d0aa&consumer_secret=cs_0e2c4571b4035f97cdac6693c71b082b79fe52a4'));

      if (response.statusCode == 200) {
        List<dynamic> allProducts = json.decode(response.body);
        List<CourseModel> courses = allProducts.map((e) => CourseModel.fromJson(e)).toList();
        return courses;
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }



  /// 1 => SEO
  /// 2 => Cloud Computing
  /// 3 => Web Development
  /// 4 => Front end development
  /// 5 => Back end Development
  /// 6 => Programming

  Future<List<CourseModel>> fetchAllCoursesByCategoryId(
      String categoryId) async {
    try {
      final courses =
          await courseRepository.getAllCoursesByCategoryId(categoryId);
      return courses;
    } catch (e) {
      SnackBars.ErrorSnackBar(title: "Oh Snap!", message: e.toString());
      return [];
    }
  }

  Future<void> fetchAllProducts() async {
    try {
      isLoading.value = true;
      final courses = await courseRepository.getAllCourses();
      allProducts.assignAll(courses);
    } catch (e) {
      SnackBars.ErrorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<CourseModel> fetchCourseById(String courseId) async {
    try {
      final courses = await courseRepository.getAllCourses();
      return courses.firstWhere((course) => course.id == courseId);
    } catch (e) {
      SnackBars.ErrorSnackBar(title: "Oh Snap!", message: e.toString());
      rethrow; // Rethrow the error to propagate it further
    } finally {
      isLoading.value = false;
    }
  }

  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;
    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  getProductPrice(CourseModel course) {
    return course.salePrice.toString();
  }

  getOriginalProductPrice(CourseModel course) {
    return course.price.toString();
  }
}
