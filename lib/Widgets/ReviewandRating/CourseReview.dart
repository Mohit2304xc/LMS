import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dummy1/Widgets/Appbar/Appbar.dart';
import 'package:dummy1/Widgets/Course/CourseDetail.dart';

class CourseReview extends StatelessWidget {
  const CourseReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarMenu(
        showBackArrow: true,
        opacity: 0,
        title: const Text("Reviews & Ratings"), onPressed: () {
          Get.to(()=>const CourseDetail());
      },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Ratings and Reviews are Verified"),
              const SizedBox(
                height: 16,
              ),
              const OverallCourseReview(),
              RatingBarIndicator(
                rating: 4.5,
                  itemSize: 20,
                  unratedColor: Colors.grey,
                  itemBuilder: (_, __) => const Icon(
                        Iconsax.star1,
                        color: Colors.purple,
                      )),
              Text("120",style: Theme.of(context).textTheme.bodySmall,),
              const SizedBox(height: 32,),

            ],
          ),
        ),
      ),
    );
  }
}

class OverallCourseReview extends StatelessWidget {
  const OverallCourseReview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '4.8',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        const Expanded(
          flex: 7,
          child: Column(
            children: [
              RatingProgressIndicator(
                text: '5',
                value: 1.0,
              ),
              RatingProgressIndicator(
                text: '5',
                value: 0.8,
              ),
              RatingProgressIndicator(
                text: '5',
                value: 0.5,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class RatingProgressIndicator extends StatelessWidget {
  const RatingProgressIndicator({
    super.key,
    required this.text,
    required this.value,
  });

  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Expanded(
            flex: 11,
            child: SizedBox(
              width: (MediaQuery.of(context).size.width) * 0.8,
              child: LinearProgressIndicator(
                value: value,
                minHeight: 25,
                backgroundColor: Colors.grey,
                borderRadius: BorderRadius.circular(7),
                valueColor: const AlwaysStoppedAnimation(Colors.purple),
              ),
            ))
      ],
    );
  }
}
