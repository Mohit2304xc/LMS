import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dummy1/Widgets/Appbar/Appbar.dart';
import 'package:dummy1/Widgets/GridLayout/GridLayout.dart';
import 'package:dummy1/Widgets/ProductCardVertical/CourseCardVertical.dart';
import '../Controller/Course/AllProductController.dart';
import '../Model/CourseModel.dart';
import '../Widgets/Animation/VerticalCourseShimmer.dart';

class AllPopularProducts extends StatelessWidget {
  const AllPopularProducts(
      {super.key,
      required this.title,
      this.query,
      required this.futureMethod,
      });

  final String title;
  final Query? query;
  final Future<List<CourseModel>> futureMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarMenu(
        showBackArrow: true,
        onPressed: () => Get.back(),
        opacity: 1,
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: FutureBuilder(
            future: futureMethod,
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
              final course = snapshot.data!;
              return SortableCourses(courses: course,);
            },
          ),
        ),
      ),
    );
  }
}

class SortableCourses extends StatelessWidget {
  const SortableCourses({
    super.key, required this.courses,
  });

  final List<CourseModel> courses;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    controller.assignCourses(courses);
    return Column(
      children: [
        DropdownButtonFormField(
          value: controller.selectedSortOption.value,
          decoration:
              const InputDecoration(prefixIcon: Icon(Icons.sort)),
          items: [
            "Name",
            "Latest",
            "Low to High",
            "High to Low",
          ]
              .map((option) => DropdownMenuItem(
                  value: option, child: Text(option)))
              .toList(),
          onChanged: (value) {
            controller.sortCourses(value!);
          },
        ),
        const SizedBox(
          height: 32,
        ),
        GetBuilder<AllProductController>(
          builder: (controller) => GridLayout(
            itemCount: controller.courses.length,
            itemBuilder: (_, index) => CourseCardVertical(
              course: controller.courses[index],
            ),
          ),
        ),
      ],
    );
  }
}
