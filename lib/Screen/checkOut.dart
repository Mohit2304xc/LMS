import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dummy1/Screen/SuccessScreen.dart';
import 'package:dummy1/Widgets/Appbar/Appbar.dart';
import 'package:dummy1/Widgets/BottomNavigation/BottomNavigationBar.dart';
import 'package:dummy1/Widgets/CircularContainer.dart';

import '../Widgets/Billing/PaymentSection.dart';
import '../Widgets/CarouselSlider/RoundedImage.dart';
import '../Widgets/CartIcon/CircularIcon.dart';
import '../Widgets/ProductCardVertical/CoursePrice.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarMenu(
        showBackArrow: true,
        opacity: 1,
        title: Text(
          "CheckOut",
          style: Theme.of(context).textTheme.titleLarge,
        ), onPressed: () { Get.back(); },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => SuccessScreen(
                title: "Payment Success!",
                subTitle: "Your Payment has been done",
                image: "assets/images/success/download.png",
                onPressed: () => Get.to(() => const NavigationMenu())));
          },
          child: const Text("CheckOut"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (_, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Column(
                          children: [
                            Text(
                              "AI Tools",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
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
                          ],
                        ),
                      ],
                    ),
                    const CoursePriceText(price: "10"),
                  ],
                ),
                separatorBuilder: (_, __) => const SizedBox(height: 32),
                itemCount: 4,
              ),
              const SizedBox(
                height: 32,
              ),
              const CouponCode(),
              const SizedBox(
                height: 32,
              ),
              const CircularContainer(
                height: 210,
                radius: 100,
                backgroundColor: Colors.white,
                child: Column(
                  children: [
                    PaymentSection(),
                    SizedBox(
                      height: 16,
                    ),
                    Divider(),
                    SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CouponCode extends StatelessWidget {
  const CouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircularContainer(
      radius: 100,
      width: 400,
      height: 100,
      backgroundColor: Colors.white,
      padding: const EdgeInsets.only(top: 8, right: 8, left: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Have a promo code? Enter here',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            width: 90,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black.withOpacity(0.5),
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.1),
                  )),
              child: const Text("Apply"),
            ),
          )
        ],
      ),
    );
  }
}
