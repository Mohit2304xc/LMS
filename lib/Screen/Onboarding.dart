import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dummy1/Controller/onboardingcontroller.dart';

import '../Onboarding/OnboardingDotNAvigation.dart';
import '../Onboarding/OnboardingNext.dart';
import '../Onboarding/OnboardingPage.dart';
import '../Onboarding/OnboardingSkip.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnboardingPage(
                  image: "assets/images/onboarding/download.jpeg",
                  title: "Get Presentation"),
              OnboardingPage(
                  image: "assets/images/onboarding/download.png",
                  title: "Watch Video"),
              OnboardingPage(
                  image: "assets/images/onboarding/download (1).jpeg",
                  title: "Read PDF and Documents"),
              OnboardingPage(
                  image: "assets/images/onboarding/download (1).png",
                  title: "Take A Test"),
              OnboardingPage(
                  image: "assets/images/onboarding/download (1).png",
                  title: "Get Certificate"),
            ],
          ),

          //skip button
          const OnboardingSkip(),

          //Next button
          const Dotnavigation(),

          const nextButton(),
        ],
      ),
    );
  }
}





