import 'package:flutter/material.dart';
import 'package:dummy1/Widgets/SectionHeading/SectionHeading.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal',style: Theme.of(context).textTheme.bodyMedium,),
            Text('£ 10',style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
        const SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total',style: Theme.of(context).textTheme.bodyMedium,),
            Text('£ 10',style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
        const Divider(),
        const SizedBox(height: 8,),
        const SectionHeading(title: "Payment Method",showActionButton: true,buttonTitle: "Change",),
        const SizedBox(height: 8,),
        Text("Paytm",style: Theme.of(context).textTheme.bodyLarge,)
      ],
    );
  }
}
