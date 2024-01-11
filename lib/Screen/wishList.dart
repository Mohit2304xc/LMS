import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dummy1/Widgets/Appbar/Appbar.dart';
import 'package:dummy1/Widgets/BottomNavigation/BottomNavigationBar.dart';
import 'package:dummy1/Widgets/CartIcon/CircularIcon.dart';
import 'package:dummy1/Widgets/ProductCardVertical/CourseCardVertical.dart';

import '../Widgets/GridLayout/GridLayout.dart';


class WishList extends StatelessWidget {
  const WishList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarMenu(
        opacity: 1,
        showBackArrow: false,
        title: Text(
          "WishList",
          style: Theme.of(context).textTheme.headlineMedium?.apply(color: Colors.white),
        ),
        actions: [
          CircularIcon(
              icon: Iconsax.add,
              onPressed: () {
                Get.to(const NavigationMenu());
              })
        ], onPressed: () { Get.to(()=>const NavigationMenu()); },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              GridLayout(itemCount: 4, itemBuilder: (_,index)=>const CoursecardVertical())
            ],
          ),
        ),
      ),
    );
  }
}
