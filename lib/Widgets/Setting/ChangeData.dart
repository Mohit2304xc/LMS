import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dummy1/Controller/UpdateNameController.dart';
import 'package:dummy1/Widgets/Appbar/Appbar.dart';
import 'package:dummy1/Widgets/Setting/ProfileScreen.dart';

import '../Validators/Validation.dart';

class ChangeData extends StatelessWidget {
  const ChangeData({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: AppbarMenu(
          title: Text(
            "Name",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          showBackArrow: true,
          onPressed: () => Get.to(() => const ProfileScreen()),
          opacity: 1),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Please enter name",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 32,
            ),
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        Validators.validateEmptyText("First Name", value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: "First Name",
                        prefixIcon: Icon(Iconsax.user)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) =>
                        Validators.validateEmptyText("Last Name", value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: "Last Name", prefixIcon: Icon(Iconsax.user)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateUserName(),
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
