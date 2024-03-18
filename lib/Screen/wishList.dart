import 'package:dummy1/Controller/FavouriteController.dart';
import 'package:dummy1/Widgets/Animation/VerticalCourseShimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dummy1/Widgets/Appbar/Appbar.dart';
import 'package:dummy1/Widgets/BottomNavigation/BottomNavigationBar.dart';
import 'package:dummy1/Widgets/ProductCardVertical/CourseCardVertical.dart';

import '../Widgets/GridLayout/GridLayout.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  @override
  Widget build(BuildContext context) {
    //final controller = FavouriteController.instance;
    return Scaffold(
      appBar: AppbarMenu(
        opacity: 1,
        showBackArrow: false,
        title: Text(
          "WishList",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.apply(color: Colors.white),
        ),
        onPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: GetBuilder<FavouriteController>(
            builder: (controller) {
              return FutureBuilder(
                future: controller.favouriteCourses(),
                builder: (context, snapshot) {
                  const loader = VerticalCourseShimmer();
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return loader;
                  }
                  if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data!.isEmpty) {
                    return const Center(
                        widthFactor: 10,
                        heightFactor: 30,
                        child: Text('Wishlist is Empty!'));
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text("Something Went Wrong."));
                  }
                  final course = snapshot.data!;
                  return GridLayout(
                    itemCount: course.length,
                    itemBuilder: (_, index) =>
                        CourseCardVertical(course: course[index]),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
