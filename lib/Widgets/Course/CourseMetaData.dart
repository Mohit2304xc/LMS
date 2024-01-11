import 'package:flutter/material.dart';
import 'package:dummy1/Widgets/ProductCardVertical/CoursePrice.dart';

import '../CircularContainer.dart';

class CourseMetaData extends StatelessWidget {
  const CourseMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircularContainer(
              width: 45,
              height: 30,
              radius: 8,
              backgroundColor: Colors.red.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                "25%",
                style: Theme.of(context).textTheme.labelLarge!.apply(
                      color: Colors.black,
                    ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            const CoursePriceText(price: "10"),
          ],
        ),
        const SizedBox(
          height: 10.5,
        ),
        Text(
          "AI Tools",
          style: Theme.of(context).textTheme.labelLarge!.apply(
                color: Colors.black,
              ),
        ),
      ],
    );
  }
}
