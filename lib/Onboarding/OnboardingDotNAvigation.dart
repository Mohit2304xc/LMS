import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:dummy1/Controller/onboardingcontroller.dart';

class Dotnavigation extends StatelessWidget {
  const Dotnavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    return Positioned(
        bottom: kBottomNavigationBarHeight + 25,
        left: 24,
        child: SmoothPageIndicator(
            effect: const ExpandingDotsEffect(
                activeDotColor: Colors.black, dotHeight: 6),
            controller: controller.pageController,
            onDotClicked: controller.dotNavigationClick,
            count: 5));
  }
}