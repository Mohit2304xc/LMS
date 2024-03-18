import 'package:dummy1/Controller/CartController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../Model/CourseModel.dart';

class CourseAddToCart extends StatelessWidget {
  const CourseAddToCart({
    super.key,
    required this.course,
  });

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return GestureDetector(
      onTap: () {
        final cartItem = cartController.convertToCartItem(course, 1);
        cartController.addOneItemToCart(cartItem);
      },
      child: Obx(
        () {
          final courseQuantityInCart =
              cartController.getProductQuantityInCart(course.id);
          return Container(
            decoration: BoxDecoration(
              color: courseQuantityInCart > 0 ? Colors.purple : Colors.black,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: SizedBox(
                width: 24 * 1.2,
                height: 24 * 1.2,
                child: Center(
                    child: courseQuantityInCart > 0
                        ? Text(
                            courseQuantityInCart.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .apply(color: Colors.white),
                          )
                        : const Icon(Iconsax.add, color: Colors.white))),
          );
        },
      ),
    );
  }
}
