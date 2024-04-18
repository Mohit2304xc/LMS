import 'dart:convert';
import 'dart:ffi';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy1/Controller/AddressController.dart';
import 'package:dummy1/Controller/CartController.dart';
import 'package:dummy1/Controller/CheckoutController.dart';
import 'package:dummy1/Controller/Course/CourseController.dart';
import 'package:dummy1/Model/AddressModel.dart';
import 'package:dummy1/Model/CartModel.dart';
import 'package:dummy1/Repository/AuthenticationRepository.dart';
import 'package:dummy1/Repository/CourseRepository.dart';
import 'package:dummy1/Screen/PaymentScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
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
import '../Widgets/API_Connection/API_connection.dart';
import 'UserController.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final cartController = CartController.instance;
  RxList<CourseModel> CourseIds = <CourseModel>[].obs;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final courseRepo = CourseRepository.instance;
  final orderRepo = Get.put(OrderRepository());
  Map<String, dynamic>? paymentIntent;

  void makePayment() async {
    try {
      paymentIntent = await createPaymentIntent();

      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "US", currencyCode: "US", testEnv: true);
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!["client_secret"],
          style: ThemeMode.dark,
          merchantDisplayName: "Mohit",
          googlePay: gpay,
        ),
      );
      displayPaymentSheet();
    } catch (e) {
      print(e.toString());
      print("Fail");
    }
  }


  void displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print("Done");
    } catch (e) {
      print(e.toString());
      print("Failed");
    }
  }

  createPaymentIntent() async {
    try {
      Map<String, dynamic> body = {
        "amount": "1000",
        "currency": "USD",
      };
      http.Response response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            "Authorization":
            "Bearer sk_test_51OwNPSSDPEOfZhhu3em3M9ixXM1HD8hf0DpydRto4utxJ2tjWkVuIn3DdVe0xAnYjADylE7TuP6KaDIqr4hPhKSU00VXxFjt4W",
            "Content-Type": "application/x-www-form-urlencoded",
          });
      return json.decode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

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

  Future<String> getCartModelByTitle(String title) async {
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
      final result = CourseModel.fromJson(courseData);
      return result.thumbnail;
    } else {
      throw 'Failed to load course data';
    }
  }



  void processOrder(double totalAmount) async {
    try {
      FullScreenLoader.openLoadingDialog('Processing your order',
          'assets/images/success/72462-check-register.json');

      final userId = UserController.instance.user.value.id;
      final items = CartController.instance.cartItems
          .map((element) => element.title)
          .toList();
      if (userId.isEmpty) {
        return;
      }
      final order = OrderModel(
        id: "1",
        userId: userId,
        status: OrderStatus.pending,
        items: items,
        paymentMethod: checkoutController.selectedPaymentMode.value.name,
        totalAmount: cartController.totalCartPrice.value.toString(),
        orderDate: DateTime.now(),
        address: AddressController.instance.selectedAddress.value.id,
      );
      print('Total Amount Type: ${totalAmount.runtimeType}');
      print('Total Amount Type: ${userId.runtimeType}');
      print(
          'Total Amount Type: ${cartController.cartItems.toList().runtimeType}');
      print(
          'Total Amount Type: ${checkoutController.selectedPaymentMode.value.name.runtimeType}');
      print(
          'Total Amount Type: ${addressController.selectedAddress.value.runtimeType}');
      print(
          '${CartController.instance.cartItems.map((element) => element.title).toList().runtimeType}');
      makePayment();
      await saveUserRecord(order);

      //await orderRepo.saveOrder(order, userId);
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

  saveUserRecord(OrderModel order) async {
    try {
      var res = await http.post(Uri.parse(API.order), body: order.toJson());
      print(res);
      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);
        print(response);
        if (response['dataUpdated'] == true) {
          SnackBars.SuccessSnackBar(title: 'Order is updated');
        } else {
          SnackBars.ErrorSnackBar(
              title: 'Error', message: "Please try again later");
        }
      }
    } catch (e) {
      print("${e.toString()}oh");
    }
  }
}

enum OrderStatus { pending, processing, delivered }
