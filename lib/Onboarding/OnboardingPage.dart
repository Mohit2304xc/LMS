import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key, required this.image, required this.title,
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
              children: [
                Image(
                    width: MediaQuery
                        .of(Get.context!)
                        .size
                        .width * 0.8,
                    height: MediaQuery
                        .of(Get.context!)
                        .size
                        .height * 0.8,
                    image:
                    AssetImage(image)),
                Text(title, style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium, textAlign: TextAlign.center,),

              ],
            ),
    );

  }
}
