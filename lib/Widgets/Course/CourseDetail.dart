import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dummy1/Widgets/BottomNavigation/BottomAddToCart.dart';
import 'package:dummy1/Widgets/Course/CourseMetaData.dart';
import 'package:dummy1/Widgets/SectionHeading/SectionHeading.dart';
import 'package:readmore/readmore.dart';

import '../../Screen/checkOut.dart';
import '../ReviewandRating/ReviewAndRatings.dart';
import 'CourseDecriptionImageDetails.dart';

class CourseDetail extends StatelessWidget {
  const CourseDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CourseDecriptionImageDetails(
              image: "assets/images/cloud/AI-Tools-bbb.png",
              mainImage: "assets/images/cloud/AI-Tools-bbb.png",
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24, left: 24, bottom: 24),
              child: Column(
                children: [
                  const ReviewandRating(),
                  const CourseMetaData(),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {Get.to(()=>const CheckoutScreen());},
                      child: const Text("CheckOut"),
                    ),
                  ),
                  const SectionHeading(
                    title: "Description",
                    showActionButton: true,
                  ),
                  const ReadMoreText("Introducing the future of innovation"
                      "AI"
                      "Tools\n – your digital sidekick for unparalleled productivity! Harness"
                      'the power of artificial intelligence with our cutting-edge'
                      'suite of tools that seamlessly blend science and artistry.'
                      'Unleash your creativity as our AI-powered design assistant'
                      'crafts stunning visuals, while'
                      'our data wizards analyze information faster than the blink of'
                      'an eye. Dive into the realm of intuitive decision'
                      '-making with predictive analytics, and let AI supercharge'
                      'your workflow.'
                      'AI Tools isn’t just a product; it’s a revolution in your toolkit'
                      '. Embrace the future today, where innovation meets imagination'
                      'and precision meets playfulness. Elevate your projects, supercharge'
                      'your ideas, and embrace the limitless possibilities of AI Tools!'),
                  const Divider(),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(children: [
                    const SectionHeading(
                      title: "Reviews (199)",
                      showActionButton: false,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Iconsax.arrow_right3,
                          size: 18,
                        ))
                  ]),
                  const SizedBox(
                    height: 16,
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
