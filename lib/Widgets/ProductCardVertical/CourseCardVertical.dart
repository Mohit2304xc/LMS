import 'package:dummy1/Controller/Course/CourseController.dart';
import 'package:dummy1/Model/CourseModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dummy1/Widgets/CarouselSlider/RoundedImage.dart';
import 'package:dummy1/Widgets/CircularContainer.dart';
import 'package:dummy1/Widgets/ProductCardVertical/CoursePrice.dart';
import '../Course/CourseAddToCart.dart';
import '../Course/CourseDetail.dart';
import '../FavouriteIcon/FavouriteIcon.dart';
import 'Details.dart';

class CourseCardVertical extends StatelessWidget {
  const CourseCardVertical({super.key, required this.course});

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    final controller = CourseController.instance;
    final salePercentage =
        controller.calculateSalePercentage(course.price, course.salePrice);
    return GestureDetector(
      onTap: () {
        Get.to(
          () => CourseDetail(
            course: course,
          ),
        );
      },
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
              radius: 15,
              padding: const EdgeInsets.only(right: 4.0,left: 4),
              child: Stack(
                children: [
                  RoundedImage(
                    image: course.thumbnail,
                    applyImageRadius: true,
                    borderRadius: 16,
                    isNetworkImage: true,
                  ),
                  if (salePercentage != null)
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
                          '$salePercentage%',
                          style: Theme.of(context).textTheme.labelLarge!.apply(
                                color: Colors.black,
                              ),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: FavouriteIcon(
                      courseId: course.id,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: DetailsForVerticalCard(
                title: course.title,
                smallSize: true,
                maxLines: 2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CoursePriceText(
                      price: controller.getOriginalProductPrice(course),
                      lineThrough: true,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CoursePriceText(price: controller.getProductPrice(course)),
                  ],
                ),
                CourseAddToCart(
                  course: course,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
