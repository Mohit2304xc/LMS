import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dummy1/Model/CategoryModel.dart';

import '../Exceptions/firebase_exceptions.dart';
import '../Exceptions/platform_exceptions.dart';
import '../Model/CourseModel.dart';
import '../Widgets/Services/FirebaseStorageService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  static const String baseUrl =
      'https://lms.prabisha.com/wp-json/wc/v3/products';
  static const String consumerKey =
      'ck_a57db437f1c9d5273d73fe76d0beac292e85d0aa';
  static const String consumerSecret =
      'cs_0e2c4571b4035f97cdac6693c71b082b79fe52a4';

  Future<List<CourseModel>> getCoursesByCategory(String categoryName) async {
    final response = await http.get(Uri.parse(
        '$baseUrl?consumer_key=$consumerKey&consumer_secret=$consumerSecret'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<CourseModel> courses = data
          .where((course) =>
      course['categories'] != null &&
          course['categories'][0]['name'] == categoryName)
          .map((json) => CourseModel.fromJson(json))
          .toList();
      return courses;
    } else {
      throw Exception('Failed to load courses');
    }
  }


  Future<List<CategoryModel>> getAllCategories() async {
    final response = await http.get(Uri.parse(
        'https://lms.prabisha.com/wp-json/wc/v3/products/categories?&consumer_key=ck_a57db437f1c9d5273d73fe76d0beac292e85d0aa&consumer_secret=cs_0e2c4571b4035f97cdac6693c71b082b79fe52a4'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<CategoryModel> categories = [];

      for (var category in data) {
        categories.add(CategoryModel.fromJson(category));
      }
      return categories;
    } else {
      throw Exception('Failed to load data');
    }
  }



  ///Upload categories
    Future<void> uploadDummyData(List<CategoryModel> categories) async {
      try {
        final storage = Get.put(FirebaseStorageService());

        for (var category in categories) {
          final file = await storage.getImageDataFromAssets(category.image);
          print(category.image);

          final url = await storage.uploadImageDataWithName(
              'Categories', file, category.name);

          category.image = url;
          await _db
              .collection("Categories")
              .doc(category.id)
              .set(category.toJson());
        }
      } on FirebaseException catch (e) {
        throw FirebaseExceptions(e.code).message;
      } on PlatformException catch (e) {
        throw PlatformExceptions(e.code).message;
      } catch (e) {
        throw 'Something went wrong';
      }
    }
  }
