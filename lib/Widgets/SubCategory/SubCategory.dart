import 'package:dummy1/Controller/CategoryController.dart';
import 'package:dummy1/Widgets/ProductCardVertical/CourseCardVertical.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dummy1/Widgets/Appbar/Appbar.dart';
import 'package:dummy1/Widgets/BottomNavigation/BottomNavigationBar.dart';
import '../../Model/CourseModel.dart';
import '../Animation/VerticalCourseShimmer.dart';
import '../GridLayout/GridLayout.dart';

class SubCategory extends StatelessWidget {
  const SubCategory({
    super.key,
    this.futureMethod,
    required this.name,
  });

  final String name;
  final Future<List<CourseModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Scaffold(
      appBar: AppbarMenu(
        showBackArrow: true,
        opacity: 1,
        title: Text(
          name,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.apply(color: Colors.white),
        ),
        onPressed: () {
          Get.to(() => const NavigationMenu());
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchCoursesByCategory(name),
            builder: (context, snapshot) {
              const loader = VerticalCourseShimmer();
              if (snapshot.connectionState == ConnectionState.waiting) {
                return loader;
              }
              if (!snapshot.hasData ||
                  snapshot.data == null ||
                  snapshot.data!.isEmpty) {
                return const Center(child: Text('No Data found!'));
              }

              if (snapshot.hasError) {
                return const Center(child: Text("Something Went Wrong."));
              }
              final courses = snapshot.data!;
              final course = controller.assignCourses(courses);
              print(course);
              return GetBuilder<CategoryController>(
                builder: (controller) => GridLayout(
                  itemCount: controller.courses.length,
                  itemBuilder: (_, index) => CourseCardVertical(
                    course: controller.courses[index],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
