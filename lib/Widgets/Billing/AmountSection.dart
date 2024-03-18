import 'package:dummy1/Controller/CartController.dart';
import 'package:dummy1/Controller/CouponCodeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmountSection extends StatelessWidget {
  const AmountSection({Key? key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () {
        final controller = CartController.instance;
        final couponController = Get.put(CouponCodeController());

        // Calculate order total based on whether coupon is applied or not
        final orderTotal = couponController.isCouponApplied
            ? controller.discountedPrice.value
            : controller.totalCartPrice.value;

        final subTotal = controller.totalCartPrice.value;
        final discount = subTotal - orderTotal; // Calculate discount

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '£ $subTotal',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Discount',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '- £ ${discount.abs()}', // Ensure discount is positive
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order Total',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '£ $orderTotal',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}


class helper {
  static Widget? checkMultiRecord<T>(
      {required AsyncSnapshot<List<T>> snapshot,
      Widget? loader,
      Widget? error,
      Widget? nothingFound}) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      if (loader != null) return loader;
      return const Center(child: CircularProgressIndicator());
    }
    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      return const Center(child: Text('No Data found!'));
    }

    if (snapshot.hasError) {
      if (error != null) return error;
      return const Center(child: Text("Something Went Wrong."));
    }

    return null;
  }
}
