import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dummy1/Controller/UserController.dart';
import 'package:dummy1/Screen/LoginScreen.dart';
import 'package:dummy1/Widgets/Appbar/Appbar.dart';
import 'package:dummy1/Widgets/BottomNavigation/BottomNavigationBar.dart';
import 'package:dummy1/Widgets/CarouselSlider/RoundedImage.dart';
import 'package:dummy1/Widgets/Curved_Edges/PrimaryHeaderContainer.dart';
import 'package:dummy1/Widgets/SectionHeading/SectionHeading.dart';
import 'package:dummy1/Widgets/Setting/ProfileScreen.dart';
import 'package:dummy1/Widgets/Setting/Settings_menu.dart';

import '../Widgets/Animation/shimmer.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              height: 280,
              child: Column(
                children: [
                  AppbarMenu(
                    opacity: 0.7,
                    onPressed: () => Get.to(() => const NavigationMenu()),
                    showBackArrow: true,
                    title: Text(
                      "Account",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const UserProfile(),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),

            ///body
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SectionHeading(
                    title: "Account Settings",
                    showActionButton: false,
                  ),
                  const SizedBox(height: 16),
                  const SettingsMenu(
                      icon: Iconsax.safe_home,
                      title: "My Orders",
                      subtitle: "In Progress and Completed Orders"),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () => Get.to(() => const LoginScreen()),
                    child: Text(
                      "Logout",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final networkImage =
        controller.user.value.profilePicture;
    final image = networkImage.isNotEmpty
        ? networkImage
        : 'assets/images/profile/download (1).png';
    return ListTile(
      leading: controller.imageLoading.value
          ? const ShimmerEffect(
        width: 80,
        height: 80,
        radius: 80,
      )
          : RoundedImage(
        image: image,
        applyImageRadius: true,
        borderRadius: 100,
        width: 80,
        height: 80,
        padding: EdgeInsets.zero,
        isNetworkImage: networkImage.isNotEmpty,
      ),
      title: Text(
        controller.user.value.fullName,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: Colors.white),
      ),
      subtitle: Text(
        controller.user.value.email,
        style:
            Theme.of(context).textTheme.bodySmall!.apply(color: Colors.white),
      ),
      trailing: IconButton(
        onPressed: () {
          Get.to(const ProfileScreen());
        },
        icon: const Icon(
          Iconsax.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
