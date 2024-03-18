import 'package:carousel_slider/carousel_slider.dart';
import 'package:dummy1/Controller/Course/CourseController.dart';
import 'package:dummy1/Widgets/Course/CourseDetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/BannerController.dart';
import '../CircularContainer.dart';
import 'RoundedImage.dart';

class Featuredcourses extends StatelessWidget {
  const Featuredcourses({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    final courseController = Get.put(CourseController());
    return FutureBuilder<void>(
      future: controller.fetchBanners(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return Column(
            children: [
              CarouselSlider(
                items: controller.banners.map((banner) {
                  return GestureDetector(
                    onTap: () async {
                      final course =
                          await courseController.findCourseByName(banner.name);
                      print(course);
                      if (course != null) {
                        Get.to(CourseDetail(course: course));
                      } else {
                        print('Course not found');
                      }
                    },
                    child: RoundedImage(
                      isNetworkImage: true,
                      image: banner.courseImage ?? '',
                      applyImageRadius: false,
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  viewportFraction: 1,
                  onPageChanged: (index, _) =>
                      controller.updatePageIndicator(index),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Obx(
                  () => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < controller.banners.length; i++)
                        CircularContainer(
                          width: 20,
                          height: 5,
                          margin: const EdgeInsets.only(right: 10),
                          backgroundColor:
                              controller.carouselCurrentIndex.value == i
                                  ? Colors.purple
                                  : Colors.grey,
                        ),
                    ],
                  ),
                ),
              )
            ],
          );
        }
      },
    );
  }
}
