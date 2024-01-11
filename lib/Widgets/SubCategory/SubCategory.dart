import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dummy1/Widgets/Appbar/Appbar.dart';
import 'package:dummy1/Widgets/BottomNavigation/BottomNavigationBar.dart';
import 'package:dummy1/Widgets/GridLayout/GridLayout.dart';

import '../ProductCardVertical/CourseCardVertical.dart';

class SubCategory extends StatelessWidget {
  const SubCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarMenu(
        showBackArrow: true,
        opacity: 1,
        title: Text(
          "Web Development",
          style: Theme.of(context).textTheme.headlineMedium?.apply(color: Colors.white),
        ), onPressed: () { Get.to(()=>const NavigationMenu()); },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              GridLayout(
                itemCount: 21,
                itemBuilder: (_, index) => const CoursecardVertical(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
