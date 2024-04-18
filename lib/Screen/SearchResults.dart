import 'package:dummy1/Controller/Course/CourseController.dart';
import 'package:dummy1/Widgets/Appbar/Appbar.dart';
import 'package:dummy1/Widgets/GridLayout/GridLayout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/Course/CourseDetail.dart';
import '../Widgets/ProductCardVertical/CourseCardVertical.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    final courseController = CourseController.instance;
    return Scaffold(
      appBar: AppbarMenu(
        showBackArrow: true,
        onPressed: () {
          Get.back();
        },
        opacity: 1,
        title: const Text(
          "Search Results",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridLayout(
            itemCount: courseController.searchProducts.length,
            itemBuilder: (context, index) {
              final product = courseController.searchProducts[index];
              print(product);
              return GestureDetector(
                  onTap: () {
                    Get.to(() => CourseDetail(course: product));
                  },
                  child: CourseCardVertical(
                    course: product,
                  ));
            },
          ),
        ),
      ),
    );
  }
}
