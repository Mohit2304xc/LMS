import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../Appbar/Appbar.dart';
import '../BottomNavigation/BottomNavigationBar.dart';
import '../CarouselSlider/RoundedImage.dart';
import '../CartIcon/CircularIcon.dart';
import '../Curved_Edges/CustomCurvedEdges.dart';

class CourseDecriptionImageDetails extends StatelessWidget {
  const CourseDecriptionImageDetails({
    super.key,
    required this.image,
    required this.mainImage,
  });

  final String image, mainImage;

  @override
  Widget build(BuildContext context) {
    return CustomCurveEdgesWidget(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(48),
                child: Center(
                  child: Image(image: AssetImage(mainImage)),
                ),
              ),
            ),
            Positioned(
              left: 24,
              right: 0,
              bottom: 30,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, index) => RoundedImage(
                        width: 80,
                        backgroundColor: Colors.white,
                        border: Border.all(color: Colors.purple),
                        image: image,
                        applyImageRadius: true,
                        borderRadius: 80),
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemCount: 4),
              ),
            ),
            AppbarMenu(
              showBackArrow: true,
              opacity: 0,
              color: Colors.black,
              onPressed: () => Get.to(() => const NavigationMenu()),
              actions: const [
                CircularIcon(
                  icon: Iconsax.heart5,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
