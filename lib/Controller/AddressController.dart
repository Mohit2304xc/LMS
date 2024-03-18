import 'package:dummy1/Widgets/Billing/AmountSection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/AddressModel.dart';
import '../Repository/addressRepository.dart';
import '../Screen/Address.dart';
import '../Widgets/Animation/FullScreenLoader.dart';
import '../Widgets/Billing/AddNewAddressPopup.dart';
import '../Widgets/SectionHeading/SectionHeading.dart';
import '../Widgets/network/NetworkManger.dart';
import '../Widgets/snackbar/Snackbar.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      SnackBars.ErrorSnackBar(
          title: 'Address not found.', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
        title: '',
        onWillPop: () async {
          return false;
        },
        barrierDismissible: false,
        backgroundColor: Colors.white,
        content: const CircularProgressIndicator(),
      );

      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);
      }

      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      await addressRepository.updateSelectedField(
          selectedAddress.value.id, true);

      Get.back();
    } catch (e) {
      SnackBars.ErrorSnackBar(
          title: 'Error in selection', message: e.toString());
    }
  }

  Future addNewAddresses() async {
    try {
      FullScreenLoader.openLoadingDialog('Storing Address...',
          'assets/images/success/141594-animation-of-docer.json');

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!addressFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      final address = AddressModel(
        name: name.text.trim(),
        id: '',
        state: state.text.trim(),
        street: street.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        city: city.text.trim(),
        selectedAddress: true,
      );

      final id = await addressRepository.addAddress(address);

      address.id = id;
      await selectAddress(address);

      FullScreenLoader.stopLoading();

      SnackBars.SuccessSnackBar(
          title: 'Congratulations',
          message: 'Your address has been saved successfully.');

      refreshData.toggle();

      resetFormFields();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      FullScreenLoader.stopLoading();
      SnackBars.ErrorSnackBar(
          title: 'Address not found.', message: e.toString());
    }
  }

  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const SectionHeading(title: 'Select Address',showActionButton: false,textColor: Colors.black,),
              const SizedBox(
                height: 16,
              ),
              FutureBuilder(
                future: getAllUserAddresses(),
                builder: (_, snapshot) {
                  final response = helper.checkMultiRecord(snapshot: snapshot);
                  if (response != null) return response;
        
                  return ListView.builder(
                    itemBuilder: (_, index) => SingleAddress(
                        address: snapshot.data![index],
                        onTap: () async {
                          await selectAddress(snapshot.data![index]);
                          Get.back();
                        }),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                  );
                },
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => Get.to(() => const AddNewAddressScreen()),
                    child: const Text("Add new address")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resetFormFields() {
    name.clear();
    postalCode.clear();
    phoneNumber.clear();
    state.clear();
    street.clear();
    city.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}
