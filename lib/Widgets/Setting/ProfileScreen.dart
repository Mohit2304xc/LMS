import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dummy1/Widgets/Animation/shimmer.dart';
import 'package:dummy1/Widgets/Appbar/Appbar.dart';
import 'package:dummy1/Widgets/BottomNavigation/BottomNavigationBar.dart';
import 'package:dummy1/Widgets/SectionHeading/SectionHeading.dart';

import '../../Controller/UserController.dart';
import '../CarouselSlider/RoundedImage.dart';
import 'ChangeData.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppbarMenu(
        showBackArrow: true,
        opacity: 1,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Get.to(() => const NavigationMenu());
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(
                      () {
                        final networkImage =
                            controller.user.value.profilePicture;
                        final image = networkImage!.isNotEmpty
                            ? networkImage
                            : 'assets/images/profile/download (1).png';
                        return controller.imageLoading.value
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
                              );
                      },
                    ),
                    TextButton(
                        onPressed: () {
                          controller.uploadUserProfilePicture();
                        },
                        child: const Text("Change Profile Picture")),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(),
              const SizedBox(
                height: 16,
              ),
              SectionHeading(
                title: "Profile Information",
                showActionButton: true,
                buttonTitle: "Edit",
                onPressed: () {Get.to(()=>const ChangeData());},
              ),
              const SizedBox(
                height: 16,
              ),
              ProfileMenu(
                field: 'Name',
                data: controller.user.value.fullName,
              ),
              const SizedBox(
                height: 10,
              ),
              ProfileMenu(
                field: 'UserId',
                data: controller.user.value.username,
              ),
              const SizedBox(
                height: 10,
              ),
              ProfileMenu(
                field: 'EmailId',
                data: controller.user.value.email,
              ),
              const SizedBox(
                height: 10,
              ),
              ProfileMenu(
                field: 'Phone Number',
                data: controller.user.value.phonenumber,
              ),
              const SizedBox(
                height: 10,
              ),
              ProfileMenu(
                field: 'Gender',
                data: 'Male',
              ),
              const SizedBox(
                height: 10,
              ),
              ProfileMenu(
                field: 'Date Of Birth',
                data: '10 Oct 1998',
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    controller.deleteAccountWarningPopup();
                  },
                  child: const Text(
                    "Close Account",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    this.onPressed,
    required this.field,
    required this.data,
  });

  final VoidCallback? onPressed;
  final String field, data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  field,
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
            Expanded(
                flex: 5,
                child: Text(
                  data,
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
          ],
        ),
      ),
    );
  }
}
