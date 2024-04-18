import 'package:dummy1/Screen/SearchResults.dart';
import 'package:dummy1/Widgets/Animation/VerticalCourseShimmer.dart';
import 'package:dummy1/Widgets/Course/CourseDetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dummy1/Screen/AllPopularProducts.dart';
import 'package:dummy1/Widgets/ProductCardVertical/CourseCardVertical.dart';
import '../Controller/Course/CourseController.dart';
import '../Widgets/Appbar/HomeAppBar.dart';
import '../Widgets/CarouselSlider/featuredCourse.dart';
import '../Widgets/CircularContainer.dart';
import '../Widgets/Curved_Edges/PrimaryHeaderContainer.dart';
import '../Widgets/GridLayout/GridLayout.dart';
import '../Widgets/PopularCategories/PopularCategories.dart';
import '../Widgets/SectionHeading/SectionHeading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final courseController = Get.put(CourseController());
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            TextField(
                              onChanged: (value) {
                                courseController.searchCourses(value);
                                courseController
                                    .toggleSearching(value.isNotEmpty);
                              },
                              controller: courseController.searchController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Search course ..',
                                hintStyle: const TextStyle(color: Colors.white),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    Get.to(const SearchResult());
                                    //courseController.searchCourses(
                                    //courseController.searchController.text);
                                  },
                                  icon: const Icon(Icons.search),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Stack(
                              children: [
                                const Column(
                                  children: [
                                    SectionHeading(
                                      textColor: Colors.white,
                                      showActionButton: false,
                                      title: 'Popular Categories',
                                    ),
                                    SizedBox(height: 16),
                                    PopularCategories(),
                                  ],
                                ),
                                Obx(
                                  () => Visibility(
                                    visible:
                                        courseController.isSearching.value &&
                                            courseController
                                                .searchProducts.isNotEmpty,
                                    child: SingleChildScrollView(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemBuilder: (_, index) {
                                            final product = courseController
                                                .searchProducts[index];
                                            return CircularContainer(
                                              width: double.infinity,
                                              height: 50,
                                              radius: 20,
                                              backgroundColor: Colors.white,
                                              child: ListTile(
                                                title: Text(product.title),
                                                trailing: IconButton(
                                                  icon: const Icon(Icons
                                                      .keyboard_arrow_right_rounded),
                                                  onPressed: () {
                                                    Get.to(() => CourseDetail(
                                                        course: product));
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: courseController.searchProducts.length,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                        futureMethod:
                            courseController.fetchAllPopularProducts(),
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
        ],
      ),
    );
  }
}
