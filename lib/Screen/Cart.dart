import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dummy1/Screen/checkOut.dart';
import 'package:dummy1/Widgets/Appbar/Appbar.dart';
import 'package:dummy1/Widgets/BottomNavigation/BottomNavigationBar.dart';
import 'package:dummy1/Widgets/CarouselSlider/RoundedImage.dart';
import 'package:dummy1/Widgets/ProductCardVertical/CoursePrice.dart';

import '../Widgets/CartIcon/CircularIcon.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => const CheckoutScreen());
          },
          child: const Text("CheckOut"),
        ),
      ),
      appBar: AppbarMenu(
        showBackArrow: true,
        opacity: 1,
        title: Text(
          "Cart",
          style: Theme.of(context).textTheme.headlineSmall,
        ), onPressed: () { Get.to(()=>const NavigationMenu()); },
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (_, index) => Column(
                  children: [
                    Row(
                      children: [
                        const RoundedImage(
                          width: 60,
                          height: 60,
                          backgroundColor: Colors.white,
                          image: "assets/images/cloud/AI-Tools-bbb.png",
                          applyImageRadius: true,
                          borderRadius: 16,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          "AI Tools",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 70,
                            ),
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
                        const CoursePriceText(price: "10"),
                      ],
                    )
                  ],
                ),
            separatorBuilder: (_, __) => const SizedBox(height: 32),
            itemCount: 4),
      ),
    );
  }
}
