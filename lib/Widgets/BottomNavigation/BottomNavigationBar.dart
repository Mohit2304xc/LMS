import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dummy1/Screen/Home.dart';
import 'package:dummy1/Screen/Profile.dart';
import 'package:dummy1/Screen/MyCourses.dart';
import 'package:dummy1/Screen/wishList.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
            NavigationDestination(icon: Icon(Iconsax.shop), label: "MyCourses"),
            NavigationDestination(icon: Icon(Iconsax.heart), label: "WishList"),
            NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const MyCourses(),
    const WishList(),
    const Profile(),
  ];
}

class navigationAfterPayment extends StatelessWidget {
  const navigationAfterPayment({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    controller.selectedIndex.value = 1;
    return GetBuilder<NavigationController>(
      builder: (controller) {
        return Scaffold(
          bottomNavigationBar: NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            destinations: const [
              NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
              NavigationDestination(
                  icon: Icon(Iconsax.shop), label: "MyCourses"),
              NavigationDestination(
                  icon: Icon(Iconsax.heart), label: "WishList"),
              NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),
            ],
          ),
          body: GetBuilder<NavigationController>(builder: (controller) => controller.screens[controller.selectedIndex.value]),
        );
      },
    );
  }
}
