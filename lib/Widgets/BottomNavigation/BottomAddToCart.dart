import 'package:dummy1/Controller/CartController.dart';
import 'package:dummy1/Model/CourseModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dummy1/Widgets/CartIcon/CircularIcon.dart';

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({super.key, required this.course});

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    controller.updateAlreadyAddedCourseCount(course);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircularIcon(
                  icon: Iconsax.minus,
                  width: 40,
                  height: 40,
                  onPressed: () => controller.courseQuantityInCart.value < 1
                      ? null
                      : controller.courseQuantityInCart.value -= 1,
                  backGroundColor: Colors.grey[200],
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  controller.courseQuantityInCart.value.toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  width: 16,
                ),
                CircularIcon(
                  icon: Iconsax.add,
                  width: 40,
                  height: 40,
                  onPressed: () => controller.courseQuantityInCart.value += 1,
                  backGroundColor: Colors.purple,
                ),
              ],
            ),
            ElevatedButton(
                onPressed: controller.courseQuantityInCart.value < 1
                    ? null
                    : () => controller.addToCart(course),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black)),
                child: const Text("Add To Cart")),
          ],
        ),
      ),
    );
  }
}

class AddToCart extends StatelessWidget {
  const AddToCart({super.key, this.add, this.remove, this.quantity});

  final VoidCallback? add, remove;
  final int? quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircularIcon(
                icon: Iconsax.minus,
                width: 40,
                height: 40,
                onPressed: remove,
                backGroundColor: Colors.grey[200],
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                quantity.toString(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(
                width: 16,
              ),
              CircularIcon(
                icon: Iconsax.add,
                width: 40,
                height: 40,
                onPressed: add,
                backGroundColor: Colors.black54,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
