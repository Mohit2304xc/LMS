import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dummy1/Widgets/Appbar/Appbar.dart';
import 'package:dummy1/Widgets/GridLayout/GridLayout.dart';
import 'package:dummy1/Widgets/ProductCardVertical/CourseCardVertical.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarMenu(
        showBackArrow: true,
        onPressed: () => Get.back(),
        opacity: 1,
        title: Text(
          "All Product",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              DropdownButtonFormField(
                decoration: const InputDecoration(prefixIcon: Icon(Icons.sort)),
                items: [
                  "Popularity",
                  "Average Rating",
                  "A to Z",
                  "Latest",
                  "Low to High",
                  "High to Low",
                ]
                    .map((option) =>
                        DropdownMenuItem(value: option, child: Text(option)))
                    .toList(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 32,),
              GridLayout(itemCount: 4, itemBuilder: (_,index)=>const CoursecardVertical()),
            ],
          ),
        ),
      ),
    );
  }
}
