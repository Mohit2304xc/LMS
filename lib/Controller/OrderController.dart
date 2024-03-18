import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy1/Controller/AddressController.dart';
import 'package:dummy1/Controller/CartController.dart';
import 'package:dummy1/Controller/CheckoutController.dart';
import 'package:dummy1/Model/CartModel.dart';
import 'package:dummy1/Repository/AuthenticationRepository.dart';
import 'package:dummy1/Repository/CourseRepository.dart';
import 'package:http/http.dart' as http;
import 'package:dummy1/Widgets/Animation/FullScreenLoader.dart';
import 'package:dummy1/Widgets/BottomNavigation/BottomNavigationBar.dart';
import 'package:dummy1/Widgets/snackbar/Snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Model/CourseModel.dart';
import '../Model/OrderModel.dart';
import '../Repository/OrderRepository.dart';
import '../Screen/SuccessScreen.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final cartController = CartController.instance;
  RxList<CourseModel> CourseIds = <CourseModel>[].obs;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final courseRepo = CourseRepository.instance;
  final orderRepo = Get.put(OrderRepository());

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepo.fetchUserOrder();
      return userOrders;
    } catch (e) {
      SnackBars.ErrorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }



  Future<List<OrderModel>> fetchUserOrdersByOrderId(String id) async {
    try {
      final userOrders = await orderRepo.fetchUserOrderByOrderId(id);
      return userOrders;
    } catch (e) {
      SnackBars.ErrorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  Future<CourseModel> getPdfBasedOnTitle(String title) async {
    final response = await http.get(Uri.parse(
        'https://lms.prabisha.com/wp-json/wc/v3/products?per_page=100&consumer_key=ck_a57db437f1c9d5273d73fe76d0beac292e85d0aa&consumer_secret=cs_0e2c4571b4035f97cdac6693c71b082b79fe52a4'));

    if (response.statusCode == 200) {
      // Parse the JSON response
      final List<dynamic> jsonResponse = json.decode(response.body);

      // Find the course with the given title
      final courseData = jsonResponse.firstWhere(
              (course) => course['name'] == title,
          orElse: () => throw 'Course not found!');

      // Create a CourseModel instance from the JSON data
      return CourseModel.fromJson(courseData);
    } else {
      throw 'Failed to load course data';
    }
  }





  Future<List<CourseModel>> fetchCourseDetails(
      List<CartModel> courseIds) async {
    for (var courseId in courseIds) {
      final future = FirebaseFirestore.instance
          .collection('CourseDetails')
          .doc(courseId.courseId)
          .get();
      //final  snapshot = future.docs.map((e) => CourseModel.fromSnapshot(e)).toList();
      CourseIds.add(future as CourseModel);
    }
    return CourseIds;
  }



  void processOrder(double totalAmount) async {
    try {
      FullScreenLoader.openLoadingDialog('Processing your order',
          'assets/images/success/72462-check-register.json');

      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        return;
      }
      final order = OrderModel(
          id: UniqueKey().toString(),
          status: OrderStatus.pending,
          totalAmount: totalAmount,
          orderDate: DateTime.now(),
          items: cartController.cartItems.toList(),
          paymentMethod: checkoutController.selectedPaymentMode.value.name,
          address: addressController.selectedAddress.value);

      await orderRepo.saveOrder(order, userId);
      cartController.clearCart();
      Get.off(() => SuccessScreen(
          title: "Payment Success!",
          subTitle: "Your Payment has been done",
          image: "assets/images/success/download.png",
          onPressed: () => Get.to(() => const NavigationMenu())));
    } catch (e) {
      SnackBars.ErrorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}

enum OrderStatus { pending, processing, delivered }
