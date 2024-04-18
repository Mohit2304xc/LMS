import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../Controller/AddressController.dart';
import '../../Screen/Address.dart';
import '../Appbar/Appbar.dart';
import '../Validators/Validation.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      appBar: AppbarMenu(
          showBackArrow: true,
          title: Text("Add New Address",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: Colors.white)),
          onPressed: () => Get.to(const AddressScreen()),
          opacity: 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controller.name,
                  validator: (value) =>
                      Validators.validateEmptyText('Name', value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user), labelText: 'Name'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: (value) => Validators.validatePhoneNumber(value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: 'Phone Number'),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: controller.street,
                      validator: (value) =>
                          Validators.validateEmptyText('Street', value),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building_31),
                          labelText: 'Street'),
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: TextFormField(
                      validator: (value) =>
                          Validators.validateEmptyText('Postal Code', value),
                      controller: controller.postalCode,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.code),
                          labelText: 'Postal Code'),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      validator: (value) =>
                          Validators.validateEmptyText('City', value),
                      controller: controller.city,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building),
                          labelText: 'City'),
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                        validator: (value) =>
                            Validators.validateEmptyText('State', value),
                        controller: controller.state,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.activity),
                            labelText: 'State'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  validator: (value) =>
                      Validators.validateEmptyText('Country', value),
                  controller: controller.country,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.global), labelText: 'Country'),
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        controller.addNewAddresses();
                      },
                      child: const Text('Save')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
