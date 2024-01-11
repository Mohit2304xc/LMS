import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dummy1/Controller/CategoryController.dart';
import 'package:dummy1/Screen/AllProducts.dart';
import 'package:dummy1/Widgets/Animation/shimmer.dart';
import 'package:dummy1/Widgets/ProductCardVertical/CourseCardVertical.dart';
import 'package:dummy1/Widgets/SubCategory/SubCategory.dart';
import '../Widgets/Appbar/HomeAppBar.dart';
import '../Widgets/CarouselSlider/featuredCourse.dart';
import '../Widgets/Curved_Edges/PrimaryHeaderContainer.dart';
import '../Widgets/GridLayout/GridLayout.dart';
import '../Widgets/SectionHeading/SectionHeading.dart';
import '../Widgets/VerticalImage/VerticalImage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryHeaderContainer(
              height: 450,
              child: Column(
                children: [
                  const HomeAppBar(),
                  const SizedBox(
                    height: 16,
                  ),
                  const SearchBar(),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Column(
                      children: [
                        const SectionHeading(
                          showActionButton: false,
                          title: 'Popular Categories',
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Obx(() {
                          if (controller.isLoading.value) {
                            return  CategoryShimmer(itemCount: controller.featuredCategories.length,);
                          } else if (controller.featuredCategories.isEmpty) {
                            return Center(
                              child: Text(
                                "No Data Found!",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(color: Colors.white),
                              ),
                            );
                          } else {
                            return SizedBox(
                              height: 80,
                              child: ListView.builder(
                                itemCount: controller.featuredCategories.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_, index) {
                                  final category =
                                      controller.featuredCategories[index];
                                  return VerticalImageText(
                                    textColor: Colors.white,
                                    image: category.image,
                                    title: category.name,
                                    onTap: () {
                                      Get.to(() => const SubCategory());
                                    },
                                  );
                                },
                              ),
                            );
                           }
                        })
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Featured Courses",
              style: Theme.of(context).textTheme.headlineMedium,
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
            SectionHeading(
              title: "Popular Products",
              showActionButton: true,
              textColor: Colors.black,
              onPressed: () => Get.to(() => const AllProducts()),
            ),
            const SizedBox(
              height: 16,
            ),
            GridLayout(
              itemCount: 4,
              itemBuilder: (_, index) => const CoursecardVertical(),
            ),
            const CoursecardVertical(),
          ],
        ),
      ),
    );
  }
}

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (_, __) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerEffect(width: 55, height: 55, radius: 55),
              SizedBox(height: 8),
              ShimmerEffect(width: 55, height: 8),
            ],
          );
        },
      ),
    );
  }
}
