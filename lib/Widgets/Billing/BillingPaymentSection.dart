import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/CheckoutController.dart';
import '../CircularContainer.dart';
import '../SectionHeading/SectionHeading.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    return Column(
      children: [
        SectionHeading(title: 'Payment Mode',textColor: Colors.black,buttonTitle: 'Change',onPressed: ()=> controller.selectPaymentMode(context)),
        const SizedBox(height: 8,),
        Obx(
          ()=> Row(
            children: [
              CircularContainer(
                width: 60,
                height: 60,
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(8),
                child: Image(image: AssetImage(controller.selectedPaymentMode.value.image),fit: BoxFit.contain,),
              ),
              const SizedBox(width: 8),
              Text(controller.selectedPaymentMode.value.name,style: Theme.of(context).textTheme.bodyLarge!.apply(color: Colors.black),)
            ],
          ),
        )
      ],
    );
  }
}
