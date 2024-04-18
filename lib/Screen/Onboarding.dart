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
                  image: "assets/images/onboarding/bb4e5a79-7612-4720-b5a8-9f1b441cda49.jpeg",
                  title: "Choose Your Path to Success", text: '\u2023 Explore and choose your desired course from a variety of options.\n \u2023 Click on the course to start learning.',),
              OnboardingPage(
                  image: "assets/images/onboarding/4c413680-aba4-4a28-adf6-e282f1d6df14.jpeg",
                  title: "Gain Access to Exclusive Learning", text: '\u2023 Enroll in your chosen course securely using various payment methods.\n \u2023 Your payment information is protected.',),
              OnboardingPage(
                  image: "assets/images/onboarding/7e2a8355-8cd9-4b1c-9404-4a0452a443c4.jpeg",
                  title: "Open the Gateway to Knowledge", text: '\u2023 Download course documents containing essential resources and guidelines.\n \u2023 Start learning at your own pace.',),
              OnboardingPage(
                  image: "assets/images/onboarding/b3a43b04-914e-40b7-bde7-abec0a327145.jpeg",
                  title: "Conquer the Course Challenge", text: '\u2023 Complete course assessments to gauge your understanding.\n \u2023 Receive instant feedback on your progress.',),
              OnboardingPage(
                  image: "assets/images/onboarding/Firefly A picture representing getting certificate for an LMS App onboarding 40055.jpg",
                  title: "Unlock Your Certificate", text: '\u2023 Download your course certificate upon successful completion.\n \u2023 Share your achievement on social media or add it to your resume.',),
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





