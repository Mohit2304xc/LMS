import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy1/Repository/AuthenticationRepository.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../Exceptions/firebase_exceptions.dart';
import '../Exceptions/platform_exceptions.dart';
import '../Model/OrderModel.dart';

class OrderRepository extends GetxController{
  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<OrderModel>> fetchUserOrder() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if(userId.isEmpty) throw 'Unable to find information.Try again in few minutes.';

      final result = await _db.collection('Users').doc(userId).collection('Orders').get();
      return result.docs.map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot)).toList();

    } catch (e) {
      print('Error: $e'); // Add this line for debugging
      throw e.toString();
    }
  }

  Future<List<OrderModel>> fetchUserOrderByOrderId(String id) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if(userId.isEmpty) throw 'Unable to find information.Try again in few minutes.';

      final result = await _db.collection('Users').doc(userId).collection('Orders').where("Id",isEqualTo: id).get();
      return result.docs.map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot)).toList();

    } catch (e) {
      print('Error: $e'); // Add this line for debugging
      throw e.toString();
    }
  }

  Future<String> PDFUrl(String url) async {
    final pdfUrl = await PDFDocument.fromURL(url);
    return 'some';
  }


  Future<List<OrderModel>> getAllCourseDocument() async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.uid;
      final snapshot = await _db.collection("Users").doc(userId).collection("Orders").get();
      return snapshot.docs.map((e) => OrderModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw PlatformExceptions(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }


  Future<void> saveOrder(OrderModel order,String userId)async{
    try{
      await _db.collection('Users').doc(userId).collection('Orders').add(order.toJson());
    } catch(e){
      throw 'Something went wrong.Try again later';
    }
  }
}