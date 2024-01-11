import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dummy1/Controller/UserController.dart';
import 'package:dummy1/Screen/LoginScreen.dart';
import 'package:dummy1/Widgets/Animation/shimmer.dart';
import '../CartIcon/CartIcon.dart';
import 'Appbar.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    this.showBackArrow = false,
  });

  final bool showBackArrow;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return AppbarMenu(
      showBackArrow: showBackArrow,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Learning Management System",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .apply(color: Colors.grey)),
          Row(
            children: [
              Text("Welcome",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .apply(color: Colors.grey)),
              const SizedBox(
                width: 16,
              ),
              Obx(() {
                if (controller.profileLoading.value) {
                  return const ShimmerEffect(width: 80, height: 15);
                } else {
                  return Text(controller.user.value.fullName,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .apply(color: Colors.grey));
                }
              }),
            ],
          ),
        ],
      ),
       actions: [
        CartIcon(
          onPressed: () {},
        ),
      ],
      opacity: 0.7,
      onPressed: () {
        Get.to(() => const LoginScreen());
      },
    );
  }
}
