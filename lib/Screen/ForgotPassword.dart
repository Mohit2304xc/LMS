import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dummy1/Controller/ForgotPasswordController.dart';
import 'package:dummy1/Widgets/Validators/Validation.dart';


class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Forgot Password",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Enter Your Email Address",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: 16,
            ),
            Form(
              key: controller.forgotPasswordFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.email,
                    validator: Validators.validateEmail ,
                    decoration: const InputDecoration(
                        labelText: "email", prefixIcon: Icon(Iconsax.direct_right)),
                  ),
                  TextFormField(
                    controller: controller.password,
                    validator: (value) => Validators.validatePassword(value) ,
                    decoration: const InputDecoration(
                        labelText: "New Password", prefixIcon: Icon(Icons.password)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.passwordResetDialog();
                  },
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
