import 'dart:io';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dummy1/Repository/AuthenticationRepository.dart';

import '../Exceptions/firebase_auth_exceptions.dart';
import '../Exceptions/firebase_exceptions.dart';
import '../Exceptions/format_exceptions.dart';
import '../Exceptions/platform_exceptions.dart';
import '../Model/Usermodel.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  //final FirebaseFirestore _db = FirebaseFirestore.instance;

  /*Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FormatExceptions();
    } on PlatformException catch (e) {
      throw PlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong.Please try again later';
    }
  }

  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
       return UserModel.empty();
      }
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FormatExceptions();
    } on PlatformException catch (e) {
      throw PlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong.Please try again later';
    }
  }

  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection("Users")
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FormatExceptions();
    } on PlatformException catch (e) {
      throw PlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong.Please try again later';
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FormatExceptions();
    } on PlatformException catch (e) {
      throw PlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong.Please try again later';
    }
  }*/

  Future<void> removeUserRecord(String userId)async{
    try{
      //await _db.collection("Users").doc(userId).delete();
    } on FirebaseAuthException catch(e){
      throw FirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch(e){
      throw FirebaseExceptions(e.code).message;
    } on FormatException catch(_){
      throw const FormatExceptions();
    } on PlatformException catch(e){
      throw PlatformExceptions(e.code).message;
    } catch(e){
      throw 'Something went wrong.Please try again later';
    }
  }

  Future<String> uploadImage(String path,XFile image)async{
    try{
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;

    } on FirebaseAuthException catch(e){
      throw FirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch(e){
      throw FirebaseExceptions(e.code).message;
    } on FormatException catch(_){
      throw const FormatExceptions();
    } on PlatformException catch(e){
      throw PlatformExceptions(e.code).message;
    } catch(e){
      throw 'Something went wrong.Please try again later';
    }
  }
}
