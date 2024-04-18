import 'dart:convert';

import 'package:dummy1/Controller/CouponCodeController.dart';
import 'package:dummy1/Controller/OrderController.dart';
import 'package:dummy1/Screen/Cart.dart';
import 'package:dummy1/Widgets/snackbar/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:dummy1/Widgets/Appbar/Appbar.dart';
import 'package:dummy1/Widgets/CircularContainer.dart';
import '../Controller/CartController.dart';
import '../Widgets/Billing/AmountSection.dart';
import 'package:http/http.dart' as http;
import '../Widgets/Billing/BillingAddressSection.dart';
import '../Widgets/Billing/BillingPaymentSection.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final orderController = Get.put(OrderController());
    final totalAmount = controller.totalCartPrice.value;
    return Scaffold(
        appBar: AppbarMenu(
          showBackArrow: true,
          opacity: 1,
          title: Text(
            "CheckOut",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.apply(color: Colors.white),
          ),
          onPressed: () {
            Get.to(() => const CartScreen());
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24),
          child: ElevatedButton(
            onPressed: () {
              orderController.processOrder(totalAmount);
            },
            child: const Text("CheckOut"),
          ),
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                CartItems(showAddRemoveButton: false),
                SizedBox(
                  height: 32,
                ),
                CouponCode(),
                SizedBox(
                  height: 32,
                ),
                CircularContainer(
                  height: 450,
                  width: 400,
                  radius: 10,
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        AmountSection(),
                        SizedBox(
                          height: 16,
                        ),
                        Divider(),
                        SizedBox(
                          height: 16,
                        ),
                        BillingPaymentSection(),
                        SizedBox(height: 16),
                        AddressSection(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class CouponCode extends StatelessWidget {
  const CouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CouponCodeController());
    final cartController = Get.put(CartController());
    var subTotal = cartController.totalCartPrice.value;
    return CircularContainer(
      radius: 100,
      width: 400,
      height: 100,
      backgroundColor: Colors.white,
      padding: const EdgeInsets.only(top: 8, right: 8, left: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: TextFormField(
              controller: controller.couponController,
              decoration: const InputDecoration(
                hintText: 'Have a promo code? Enter here',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            width: 90,
            child: ElevatedButton(
              onPressed: () {
                final afterDiscount = controller.applyCoupon(context, subTotal);
                cartController.updateFinalAmount(afterDiscount);
                SnackBars.SuccessSnackBar(title: 'Coupon has been applied!');
              },
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black.withOpacity(0.5),
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.1),
                  )),
              child: const Text("Apply"),
            ),
          )
        ],
      ),
    );
  }
}
