//import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import 'package:dummy1/Controller/UserController.dart';
import 'package:dummy1/Repository/AuthenticationRepository.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import '../Exceptions/firebase_exceptions.dart';
import '../Exceptions/platform_exceptions.dart';
import '../Model/OrderModel.dart';
import '../Widgets/API_Connection/API_connection.dart';
import '../Widgets/snackbar/Snackbar.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  //final _db = FirebaseFirestore.instance;

  RxList<String> items = <String>[].obs;

  Future<List<OrderModel>> fetchUserOrder() async {
    try {
      final userId = UserController.instance.user.value.id;
      if (userId.isEmpty) {
        throw 'Unable to find information. Try again in a few minutes.';
      }
      final res = await http.post(
        Uri.parse(API.fetchOrder),
        body: {'user_id': userId},
      );
      if (res.statusCode == 200) {
        final response = json.decode(res.body);
        if (response['success'] == true) {
          final List<dynamic> resp = response["userOrders"];
          print(resp);
          List<OrderModel> orders = resp.map((order) { return OrderModel.fromJson(order);}).toList();
          items.value = orders.expand((e) => e.items).toSet().toList();
          print("items : $items");
          return orders;
        } else {
          SnackBars.ErrorSnackBar(
              title: 'Error',
              message: "Please try again later"
          );
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching user order: $e');
      throw 'Error fetching user order: $e';
    }

  }



  Future<List<OrderModel>> fetchUserOrderByOrderId(String id) async {
    List<OrderModel> orders = [];
    try {
      final userId = UserController.instance.user.value.id;
      if(userId.isEmpty) throw 'Unable to find information.Try again in few minutes.';

      //final result = await _db.collection('Users').doc(userId).collection('Orders').where("Id",isEqualTo: id).get();
      //return result.docs.map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot)).toList();
      final result = await fetchUserOrder();
      for(OrderModel order in result){
        if(order.id == id){
          orders.add(order);
        }
      }
      return orders;
    } catch (e) {
      print('Error: $e'); // Add this line for debugging
      throw e.toString();
    }
  }

  Future<String> PDFUrl(String url) async {
    final pdfUrl = await PDFDocument.fromURL(url);
    return 'some';
  }

/*Future<List<OrderModel>> getAllCourseDocument() async {
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
  }*/

/*Future<void> saveOrder(OrderModel order,String userId)async{
    try{
      await _db.collection('Users').doc(userId).collection('Orders').add(order.toJson());
    } catch(e){
      throw 'Something went wrong.Try again later';
    }
  }*/
}
