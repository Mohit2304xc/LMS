import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../Controller/FavouriteController.dart';
import '../CartIcon/CircularIcon.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({
    super.key, required this.courseId,
  });

  final String courseId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouriteController());
    return Obx(
      () => CircularIcon(
        icon: controller.isFavourite(courseId) ? Iconsax.heart5 : Iconsax.heart,
        color: controller.isFavourite(courseId) ? Colors.red : null,
        onPressed: () => controller.toggleFavouriteCourse(courseId),
      ),
    );
  }
}