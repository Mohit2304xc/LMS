import 'package:dummy1/Controller/Course/CourseController.dart';
import 'package:dummy1/Model/CourseModel.dart';
import 'package:flutter/material.dart';
import 'package:dummy1/Widgets/ProductCardVertical/CoursePrice.dart';

import '../CircularContainer.dart';

class CourseMetaData extends StatelessWidget {
  const CourseMetaData({super.key, required this.course});

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    final controller = CourseController.instance;
    final salePercentage = controller.calculateSalePercentage(
        course.price, double.tryParse(course.salePrice));
    final hasSalePrice = course.salePrice != "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Visibility(
              visible: hasSalePrice,
              child: CircularContainer(
                width: 45,
                height: 30,
                radius: 8,
                backgroundColor: Colors.red.withOpacity(0.8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  '$salePercentage%',
                  style: Theme.of(context).textTheme.labelLarge!.apply(
                        color: Colors.black,
                      ),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Visibility(
              visible: hasSalePrice,
              child: CoursePriceText(
                price: controller.getOriginalProductPrice(course),
                lineThrough: true,
              ),
            ),
            Visibility(
              visible: hasSalePrice == false,
              child: CoursePriceText(
                price: controller.getOriginalProductPrice(course),
                lineThrough: false,
              ),
            ),
            Visibility(
              visible: hasSalePrice,
              child: const SizedBox(width: 10),
            ),
            Visibility(
                visible: hasSalePrice,
                child:
                    CoursePriceText(price: controller.getProductPrice(course))),
          ],
        ),
        const SizedBox(
          height: 10.5,
        ),
        Text(
          course.title,
          style: Theme.of(context).textTheme.titleLarge!.apply(
                color: Colors.black,
              ),
        ),
      ],
    );
  }
}
