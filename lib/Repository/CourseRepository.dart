import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy1/Widgets/snackbar/Snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Exceptions/firebase_exceptions.dart';
import '../Exceptions/platform_exceptions.dart';
import '../Model/CourseModel.dart';
import '../Widgets/Services/FirebaseStorageService.dart';

class CourseRepository extends GetxController {
  static CourseRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> pickFile(String title) async {
    try {
      final storage = Get.put(FirebaseStorageService());
      final pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf','docx','jpg'],
      );
      print("yes");
      if (pickedFile != null) {
        String fileName = pickedFile.files[0].name;
        File file = File(pickedFile.files[0].path!);
        final url = await storage.uploadDocument(fileName, file);
        QuerySnapshot querySnapshot = await _db
            .collection('CourseDetails')
            .where("Title", isEqualTo: title)
            .get();
        print("no");
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          // Get reference to the document
          DocumentReference docRef = FirebaseFirestore.instance
              .collection('CourseDetails')
              .doc(doc.id);

          // Update the document with the new field
          await docRef.update({
            'Document': url,
          });
        }
        print("done");
        return SnackBars.SuccessSnackBar(
            title: 'Success!', message: 'Document Uploaded Successfully');
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<CourseModel>> searchCourses(String query) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _db
          .collection('CourseDetails')
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      List<CourseModel> courses = snapshot.docs.map((doc) {
        return CourseModel.fromSnapshot(doc);
      }).toList();

      return courses;
    } catch (e) {
      // Handle errors here
      print('Error searching courses: $e');
      return [];
    }
  }

  Future<List<CourseModel>> getPopularCourses() async {
    try {
      final snapshot = await _db
          .collection("CourseDetails")
          .limit(4)
          .where('IsFeatured', isEqualTo: true)
          .get();
      return snapshot.docs.map((e) => CourseModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw PlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  Future<List<CourseModel>> fetchCoursesByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<CourseModel> courseList = querySnapshot.docs
          .map((e) => CourseModel.fromQuerySnapshot(e))
          .toList();
      return courseList;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw PlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong';
    }
  }


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


  Future<List<CourseModel>> getAllPopularCourses() async {
    try {
      final snapshot = await _db
          .collection("CourseDetails")
          .where('IsFeatured', isEqualTo: true)
          .get();
      return snapshot.docs.map((e) => CourseModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw PlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  Future<List<CourseModel>> getAllCoursesByCategoryId(String categoryId) async {
    try {
      final snapshot = await _db
          .collection("CourseDetails")
          .where('CategoryId', isEqualTo: categoryId)
          .get();
      return snapshot.docs.map((e) => CourseModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw PlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  Future<List<CourseModel>> getAllCourseDocument(String? titleField) async {
    try {
      final snapshot = await _db
          .collection("CourseDetails")
          .where('Title', isEqualTo: titleField)
          .get();
      return snapshot.docs.map((e) => CourseModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw PlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  Future<List<CourseModel>> getAllCourses() async {
    try {
      final snapshot = await _db.collection("CourseDetails").get();
      return snapshot.docs.map((e) => CourseModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw PlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  Future<void> uploadDummyData(List<CourseModel> courses) async {
    try {
      final storage = Get.put(FirebaseStorageService());

      for (var course in courses) {
        final thumbnail =
            await storage.getImageDataFromAssets(course.thumbnail);

        final url = await storage.uploadImageData('Courses/Images', thumbnail);

        course.thumbnail = url;

        if (course.images != null && course.images!.isNotEmpty) {
          List<String> imagesUrl = [];
          for (var image in course.images!) {
            final assetImage = await storage.getImageDataFromAssets(image);
            final url =
                await storage.uploadImageData('Courses/Images', assetImage);
            imagesUrl.add(url);
          }
          course.images!.clear();
          course.images!.addAll(imagesUrl);
        }
        await _db
            .collection("CourseDetails")
            .doc(course.id)
            .set(course.toJson());
      }
      SnackBars.SuccessSnackBar(title: 'Congratulations',message: 'Course has been updated in firebase!');
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw PlatformExceptions(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }
}
