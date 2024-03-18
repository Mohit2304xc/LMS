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
                  title: "Select Course", text: '\u2023 Explore and choose your desired course from a variety of options.\n \u2023 Click on the course to start learning.',),
              OnboardingPage(
                  image: "assets/images/onboarding/download.png",
                  title: "Pay for Course", text: '\u2023 Enroll in your chosen course securely using various payment methods.\n \u2023 Your payment information is protected.',),
              OnboardingPage(
                  image: "assets/images/onboarding/download (1).jpeg",
                  title: "Access Course Material", text: '\u2023 Download course documents containing essential resources and guidelines.\n \u2023 Start learning at your own pace.',),
              OnboardingPage(
                  image: "assets/images/onboarding/download (1).png",
                  title: "Take Course Test", text: '\u2023 Complete course assessments to gauge your understanding.\n \u2023 Receive instant feedback on your progress.',),
              OnboardingPage(
                  image: "assets/images/onboarding/download (1).png",
                  title: "Get Course Certificate", text: '\u2023 Download your course certificate upon successful completion.\n \u2023 Share your achievement on social media or add it to your resume.',),
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





