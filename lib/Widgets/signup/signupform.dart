import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

//import 'package:dummy1/Controller/SignUpController.dart';
import 'package:dummy1/Widgets/Validators/Validation.dart';

import '../../Controller/Signupcontroller.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      Validators.validateEmptyText("First Name", value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: "First Name", prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      Validators.validateEmptyText("Last Name", value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: "Last Name", prefixIcon: Icon(Iconsax.user)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: controller.username,
            validator: (value) =>
                Validators.validateEmptyText("User Name", value),
            expands: false,
            decoration: const InputDecoration(
              labelText: "Username",
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: controller.email,
            validator: (value) => Validators.validateEmail(value),
            expands: false,
            decoration: const InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => Validators.validatePhoneNumber(value),
            expands: false,
            decoration: const InputDecoration(
              labelText: "Phone Number",
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Obx(
            () => TextFormField(
              obscureText: controller.hidePassword.value,
              controller: controller.password,
              validator: (value) => Validators.validatePassword(value),
              expands: false,
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
            height: 16,
          ),
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 2,
                child: //Obx(
                    //() =>
                    Checkbox(
                  value: controller.privacyPolicy.value,
                  onChanged: (value) {
                    controller.privacyPolicy.value =
                        !controller.privacyPolicy.value;
                  },
                ),
              ),
              //),
              const SizedBox(
                width: 8,
              ),
              const Text("I agree to all Terms and Conditions"),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text("Create Account"),
            ),
          )
        ],
      ),
    );
  }
}
