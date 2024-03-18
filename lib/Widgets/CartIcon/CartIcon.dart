import 'package:dummy1/Controller/CartController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dummy1/Screen/Cart.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({
    super.key,
    required this.onPressed,
    this.IconColor = Colors.white,
  });

  final VoidCallback onPressed;
  final Color? IconColor;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => const CartScreen()),
          icon: const Icon(
            Iconsax.shopping_bag,
            color: Colors.white,
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Obx(
                () => Text(
                  controller.noOfCartItems.value.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: IconColor, fontSizeFactor: 0.8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
