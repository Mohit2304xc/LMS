import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dummy1/Widgets/Appbar/Appbar.dart';
import 'package:dummy1/Widgets/BottomNavigation/BottomNavigationBar.dart';

import '../Widgets/CarouselSlider/RoundedImage.dart';

class MyCourses extends StatelessWidget {
  const MyCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarMenu(
        opacity: 1,
        showBackArrow: true,
        title: Text(
          "My Course",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.apply(color: Colors.white),
        ), onPressed: () { Get.to(()=>const NavigationMenu()); },
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
                            TextButton(onPressed: (){}, child: const Text("View Progress"))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                separatorBuilder: (_, __) => const SizedBox(height: 32),
                itemCount: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
