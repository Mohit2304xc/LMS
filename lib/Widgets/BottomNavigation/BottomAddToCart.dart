import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dummy1/Widgets/CartIcon/CircularIcon.dart';

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircularIcon(
                icon: Iconsax.minus,
                width: 40,
                height: 40,
                backGroundColor: Colors.grey[200],
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                "2",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(
                width: 16,
              ),
              CircularIcon(
                icon: Iconsax.add,
                width: 40,
                height: 40,
                backGroundColor: Colors.grey[200],
              ),
            ],
          ),
          ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16),backgroundColor: Colors.black,side: const BorderSide(color: Colors.black)),child: const Text("Add To Cart"))
        ],
      ),
    );
  }
}
