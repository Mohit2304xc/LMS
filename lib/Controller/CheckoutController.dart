import 'package:dummy1/Model/PaymentModel.dart';
import 'package:dummy1/Widgets/CircularContainer.dart';
import 'package:dummy1/Widgets/SectionHeading/SectionHeading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentModel> selectedPaymentMode = PaymentModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMode.value = PaymentModel(
        name: 'Paytm', image: 'assets/images/PaymentImages/download.png');
    super.onInit();
  }

  Future<dynamic> selectPaymentMode(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeading(title: 'Select Payment Method',showActionButton: false,),
              const SizedBox(height: 32),
              PaymentTile(paymentMode: PaymentModel(name: 'Paytm', image: 'assets/images/PaymentImages/download.png'),),
              const SizedBox(height: 8),
              PaymentTile(paymentMode: PaymentModel(name: 'PhonePe', image: 'assets/images/PaymentImages/download (1).png'),),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}


class PaymentTile extends StatelessWidget {
  const PaymentTile({super.key, required this.paymentMode});

  final PaymentModel paymentMode;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: (){
        controller.selectedPaymentMode.value = paymentMode;
        Get.back();
      },
      leading: CircularContainer(
        width: 60,
        height: 40,
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(8),
        child: Image(image: AssetImage(paymentMode.image),fit: BoxFit.contain,),
      ),
      title: Text(paymentMode.name),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
