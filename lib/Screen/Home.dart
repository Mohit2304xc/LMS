import 'package:dummy1/Dummy_data.dart';
import 'package:dummy1/Widgets/Animation/VerticalCourseShimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dummy1/Screen/AllPopularProducts.dart';
import 'package:dummy1/Widgets/ProductCardVertical/CourseCardVertical.dart';
import '../Controller/CategoryController.dart';
import '../Controller/Course/CourseController.dart';
import '../Widgets/Animation/CategoryShimmer.dart';
import '../Widgets/Appbar/HomeAppBar.dart';
import '../Widgets/CarouselSlider/featuredCourse.dart';
import '../Widgets/Curved_Edges/PrimaryHeaderContainer.dart';
import '../Widgets/GridLayout/GridLayout.dart';
import '../Widgets/PopularCategories/PopularCategories.dart';
import '../Widgets/SectionHeading/SectionHeading.dart';
import '../Widgets/SubCategory/SubCategory.dart';
import '../Widgets/VerticalImage/VerticalImage.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final courseController = Get.put(CourseController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PrimaryHeaderContainer(
              height: 450,
              child: Column(
                children: [
                  HomeAppBar(),
                  SizedBox(
                    height: 16,
                  ),
                  SearchBar(),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: Column(
                      children: [
                        SectionHeading(
                          textColor: Colors.white,
                          showActionButton: false,
                          title: 'Popular Categories',
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        PopularCategories(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Text(
                "Featured Courses",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.all(24),
              child: Featuredcourses(),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: SectionHeading(
                title: "Popular Products",
                showActionButton: true,
                textColor: Colors.black,
                onPressed: () => Get.to(
                  () => AllPopularProducts(
                    title: 'Popular Courses',
                    futureMethod: courseController.fetchAllPopularProducts(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GetBuilder<CourseController>(
              builder: (courseController) {
                if (courseController.isLoading.value) {
                  return const VerticalCourseShimmer();
                }
                if (courseController.popularProducts.isEmpty) {
                  courseController.fetchPopularProducts();
                  return Center(
                    child: Text(
                      'Loading...',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                }
                return GridLayout(
                  itemCount: courseController.popularProducts.length,
                  itemBuilder: (_, index) => CourseCardVertical(
                    course: courseController.popularProducts[index],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

