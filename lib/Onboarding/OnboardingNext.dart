import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:dummy1/Controller/onboardingcontroller.dart';

class nextButton extends StatelessWidget {
  const nextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 24,
      bottom: kBottomNavigationBarHeight,
      child: ElevatedButton(
        onPressed: () {
          OnboardingController.instance.nextPage();
        },
        style: ElevatedButton.styleFrom(shape: const CircleBorder()),
        child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}
