import 'package:dummy1/Model/CourseModel.dart';
import 'package:dummy1/Widgets/GridLayout/GridLayout.dart';
import 'package:dummy1/Widgets/ProductCardVertical/CourseCardVertical.dart';
import 'package:dummy1/Widgets/snackbar/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Repository/CourseRepository.dart';

class CourseController extends GetxController {
  static CourseController get instance => Get.find();

  RxList<CourseModel> popularProducts = <CourseModel>[].obs;
  RxList<CourseModel> searchProducts = <CourseModel>[].obs;
  RxList<CourseModel> allProducts = <CourseModel>[].obs;
  final isLoading = false.obs;
  final isSearching = false.obs;
  final searchController = TextEditingController();
  String searchText = '';
  final title = Get.put(TextEditingController());
  final RxList<CourseModel> courses = <CourseModel>[].obs;
  final courseRepository = CourseRepository.instance;

  @override
  void onInit() {
    fetchPopularProducts();
    fetchAllPopularProducts();
    super.onInit();
  }

  toggleSearching(bool value){
    isSearching.value = value;
  }

  search(String query){
    searchText = query;
    updateData();
  }

  updateData(){
    searchProducts.clear();
    if(searchText.isNotEmpty){
      searchProducts.addAll(allProducts.where((element) => element.title.toLowerCase().contains(searchText)).toList());
    }
  }

  void searchCourses(String query) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://lms.prabisha.com/wp-json/wc/v3/products?search=$query&per_page=100&consumer_key=ck_a57db437f1c9d5273d73fe76d0beac292e85d0aa&consumer_secret=cs_0e2c4571b4035f97cdac6693c71b082b79fe52a4'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        List<CourseModel> products = jsonResponse
            .map((data) => CourseModel.fromJson(data))
            .toList();
        searchText = query;
        searchProducts.clear();
        searchProducts.value = products.where((element) => element.title.toLowerCase().startsWith(searchText)).toList();

      } else {
        print('Failed to load courses: ${response.statusCode}');
      }
    } catch (e) {
      print('Error searching courses: $e');
    }
  }




  Future<CourseModel?> findCourseByName(String name) async {
    final courses = await fetchAllPopularProducts();
    final matchingCourse = courses.firstWhere((course) => course.title == name, orElse: () => null as CourseModel);
    return matchingCourse;
  }




  void assignCourses(List<CourseModel> courses) {
    this.courses.assignAll(courses);
  }

  /*Future<List<CourseModel>> fetchCoursesByQuery(Query? query) async {
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
  }*/

 /* void searchCourses(String query) async {
    searchProducts.value = await courseRepository.searchCourses(query);
  }*/

  Future<List<CourseModel>> getFavouriteCourses(List<String> courseId) async {
    try {
      final response = await http.get(Uri.parse(
          'https://lms.prabisha.com/wp-json/wc/v3/products?consumer_key=ck_a57db437f1c9d5273d73fe76d0beac292e85d0aa&consumer_secret=cs_0e2c4571b4035f97cdac6693c71b082b79fe52a4'));

      if (response.statusCode == 200) {
        List<dynamic> allProducts = json.decode(response.body);

        // Filter products based on the courseId
        List<CourseModel> course = [];
        for (var product in allProducts) {
          if (courseId.contains(product['id'].toString())) {
            course.add(CourseModel.fromJson(product));
          }
        }

        print(course);
        return course;
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
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
                String data = Get.find<TextEditingController>().text;
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

  /*Future<List<CourseModel>> fetchAllCoursesByCategoryId(
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
  }*/

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



