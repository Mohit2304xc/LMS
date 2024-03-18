import 'package:dummy1/Controller/AddressController.dart';
import 'package:dummy1/Model/AddressModel.dart';
import 'package:dummy1/Widgets/Appbar/Appbar.dart';
import 'package:dummy1/Widgets/Billing/AmountSection.dart';
import 'package:dummy1/Widgets/BottomNavigation/BottomNavigationBar.dart';
import 'package:dummy1/Widgets/CircularContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../Widgets/Billing/AddNewAddressPopup.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      appBar: AppbarMenu(
          showBackArrow: true,
          title: Text("Addresses",
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: Colors.white)),
          onPressed: () => const NavigationMenu(),
          opacity: 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Obx(
                () =>
                FutureBuilder(
                  key: Key(controller.refreshData.value.toString()),
                  future: controller.getAllUserAddresses(),
                  builder: (context, snapshot) {
                    final response = helper.checkMultiRecord(
                        snapshot: snapshot);
                    if (response != null) return response;

                    return ListView.builder(
                      itemBuilder: (_, index) =>
                          SingleAddress(
                              address: snapshot.data![index],
                              onTap: () async {
                                await controller.selectAddress(
                                    snapshot.data![index]);
                                Get.back();
                              }),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                    );
                  },
                ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        backgroundColor: Colors.purple,
        child: const Icon(
          Iconsax.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class SingleAddress extends StatelessWidget {
  const SingleAddress({
    super.key,
    required this.address,
    required this.onTap,
  });

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;

    final selectedAddressId = controller.selectedAddress.value.id;
    final selectedAddress = selectedAddressId == address.id;
    return InkWell(
      onTap: onTap,
      child: CircularContainer(
        radius: 25,
        height: 125,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        backgroundColor: selectedAddress
            ? Colors.purple.withOpacity(0.7)
            : Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              right: 5,
              top: 0,
              child: Icon(
                selectedAddress ? Iconsax.tick_circle5 : null,
                color: selectedAddress ? Colors.white : null,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    address.formattedPhoneNo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    address.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge,
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