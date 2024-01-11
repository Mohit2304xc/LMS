import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dummy1/Model/categoryModel.dart';

import '../Exceptions/firebase_exceptions.dart';
import '../Exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController{
  static CategoryRepository get instance => Get.find();


  final _db = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getAllCategories()async{
    try{
       final snapshot = await _db.collection('Categories').get();
       final list = snapshot.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
       return list;
    } on FirebaseException catch(e){
      throw FirebaseExceptions(e.code).message;
    } on PlatformException catch(e){
      throw PlatformExceptions(e.code).message;
    } catch(e){
      throw 'Something went wrong';
    }
  }

  Future<void> uploadDummyData(List<CategoryModel> categories)async{
    try{
      final storage = Get.put(FirebaseStorageService());

      for(var category in categories){
        final file = await storage.getImageDataFromAssets(category.image);

        final url = await storage.uploadImageData('Categories',file,category.name);

        category.image = url;
        await _db.collection("Categories").doc(category.id).set(category.toJson());
      }
    } on FirebaseException catch(e){
      throw FirebaseExceptions(e.code).message;
    } on PlatformException catch(e){
      throw PlatformExceptions(e.code).message;
    } catch(e){
      throw 'Something went wrong';
    }
  }
}


class FirebaseStorageService extends GetxController{
  static FirebaseStorageService get instance => Get.find();

  final _firebaseStorage = FirebaseStorage.instance;

  Future<Uint8List> getImageDataFromAssets(String path)async{
    try{
      final byteData = await rootBundle.load(path);
      final imageData = byteData.buffer.asUint8List(byteData.offsetInBytes,byteData.lengthInBytes);
      return imageData;
    } catch(e){
      throw 'Error loading image data: $e';
    }
  }

  Future<String> uploadImageData(String path,Uint8List image,String name)async{
    try{
      final ref = _firebaseStorage.ref(path).child(name);
      await ref.putData(image);
      final url = await ref.getDownloadURL();
      return url;
    } catch(e){
      if(e is FirebaseException){
        throw 'Firebase Exception: ${e.message}';
      } else if(e is SocketException){
        throw 'Network Error: ${e.message}';
      } else if(e is PlatformException){
        throw 'Platform Exception: ${e.message}';
      } else{
        throw 'Something went wrong! Please try again.';
      }
    }
  }

  Future<String> uploadImageFile(String path,XFile image)async{
    try{
      final ref = _firebaseStorage.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } catch(e){
      if(e is FirebaseException){
        throw 'Firebase Exception: ${e.message}';
      } else if(e is SocketException){
        throw 'Network Error: ${e.message}';
      } else if(e is PlatformException){
        throw 'Platform Exception: ${e.message}';
      } else{
        throw 'Something went wrong! Please try again.';
      }
    }
  }
}