import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dummy1/Widgets/CarouselSlider/RoundedImage.dart';
import 'package:dummy1/Widgets/CircularContainer.dart';
import 'package:dummy1/Widgets/ProductCardVertical/CoursePrice.dart';

import '../CartIcon/CircularIcon.dart';
import 'Details.dart';

class CoursecardVertical extends StatelessWidget {
  const CoursecardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300.withOpacity(0.1),
                blurRadius: 50,
                spreadRadius: 7,
                offset: const Offset(0, 2)),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            CircularContainer(
              height: 180,
              padding: const EdgeInsets.all(4.0),
              child: Stack(
                children: [
                  const RoundedImage(
                      image: "assets/images/cloud/aws.png",
                      applyImageRadius: true,
                      borderRadius: 16),
                  Positioned(
                    top: 0,
                    child: CircularContainer(
                      width: 45,
                      height: 30,
                      radius: 8,
                      backgroundColor: Colors.red.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Text(
                        "25%",
                        style: Theme.of(context).textTheme.labelLarge!.apply(
                              color: Colors.black,
                            ),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: CircularIcon(
                      icon: Iconsax.heart5,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: DetailsForVerticalCard(
                title: 'AWS',
                smallSize: true,
                maxLines: 2,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CoursePriceText(price: "10"),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: const SizedBox(
                      width: 24 * 1.2,
                      height: 24 * 1.2,
                      child: Icon(Iconsax.add, color: Colors.white)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
