import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/AddressController.dart';
import '../SectionHeading/SectionHeading.dart';

class AddressSection extends StatelessWidget {
  const AddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Obx(
      () {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeading(
              textColor: Colors.black,
              title: 'Shipping Address',
              buttonTitle: 'Change',
              onPressed: () => controller.selectNewAddressPopup(context),
            ),
            controller.selectedAddress.value.id.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.selectedAddress.value.name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.phone, color: Colors.grey, size: 16),
                          const SizedBox(width: 16),
                          Text(
                            controller.selectedAddress.value.phoneNumber,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_history,
                              color: Colors.grey, size: 16),
                          const SizedBox(width: 16),
                          Expanded(
                              child: Text(
                                  controller.selectedAddress.value.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .apply(color: Colors.black),
                                  softWrap: true)),
                        ],
                      ),
                    ],
                  )
                : Text(
                    'Select Address',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(color: Colors.black),
                  ),
          ],
        );
      },
    );
  }
}
