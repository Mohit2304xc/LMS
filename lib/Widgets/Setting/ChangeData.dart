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
            "Details",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .apply(color: Colors.white),
          ),
          showBackArrow: true,
          onPressed: () => Get.to(() => const ProfileScreen()),
          opacity: 1),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Please enter details",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 32,
              ),
              Form(
                key: controller.firstNameFormKey,
                child: TextFormField(
                  controller: controller.firstNameController,
                  validator: (value) =>
                      Validators.validateEmptyText("First Name", value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: "First Name", prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: controller.lastNameFormKey,
                child: TextFormField(
                  controller: controller.lastNameController,
                  validator: (value) =>
                      Validators.validateEmptyText("Last Name", value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: "Last Name", prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: controller.usernameFormKey,
                child: TextFormField(
                  controller: controller.usernameController,
                  validator: (value) =>
                      Validators.validateEmptyText("User Name", value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: "User Name", prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: controller.phoneNumberFormKey,
                child: TextFormField(
                  controller: controller.phoneNumberController,
                  validator: (value) => Validators.validatePhoneNumber(value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: "Phone Number", prefixIcon: Icon(Icons.phone)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: controller.existingEmailFormKey,
                child: TextFormField(
                  controller: controller.existingEmailController,
                  validator: (value) =>
                      Validators.validateEmptyText("Existing Email", value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: "Existing Email", prefixIcon: Icon(Icons.email)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: controller.newEmailFormKey,
                child: TextFormField(
                  controller: controller.newEmailController,
                  validator: (value) =>
                      Validators.validateEmptyText("New Email", value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: "New Email", prefixIcon: Icon(Icons.email)),
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
      ),
    );
  }
}
