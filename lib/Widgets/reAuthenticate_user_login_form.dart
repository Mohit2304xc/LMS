import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dummy1/Controller/UserController.dart';
import 'package:dummy1/Widgets/Appbar/Appbar.dart';

import 'Setting/ChangeData.dart';
import 'Validators/Validation.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppbarMenu(
          title: Text(
            "Re-Authenticate User",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          showBackArrow: true,
          onPressed: () => Get.to(() => const ChangeData()),
          opacity: 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: Validators.validateEmail,
                  decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Iconsax.direct_right)),
                ),
                const SizedBox(
                  height: 16,
                ),
                Obx(
                  () => TextFormField(
                    obscureText: controller.hidePassword.value,
                    controller: controller.verifyPassword,
                    validator: (value) =>
                        Validators.validateEmptyText('Password', value),
                    decoration: InputDecoration(
                      labelText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(controller.hidePassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye),
                        onPressed: () {
                          controller.hidePassword.value =
                              !controller.hidePassword.value;
                        },
                      ),
                      prefixIcon: const Icon(Iconsax.password_check),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () =>
                          controller.reAuthenticateEmailAndPasswordUser(),
                      child: const Text("Continue")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
