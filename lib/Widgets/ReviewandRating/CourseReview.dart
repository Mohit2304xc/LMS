import 'package:dummy1/Model/CourseModel.dart';
import 'package:dummy1/Widgets/ReviewandRating/UserReviewCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dummy1/Widgets/Appbar/Appbar.dart';
import 'package:dummy1/Widgets/Course/CourseDetail.dart';

import '../../Controller/RatingAndReviewController.dart';
import '../../Model/ReviewModel.dart';

class CourseReview extends StatelessWidget {
  const CourseReview({super.key, required this.course});

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReviewAndRatingController());
    final reviewsFuture = controller.fetchReviewAndRating(course.title);

    return Scaffold(
      appBar: AppbarMenu(
        showBackArrow: true,
        opacity: 1,
        color: Colors.white,
        title: Text(
          "Reviews & Ratings",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .apply(color: Colors.white),
        ),
        onPressed: () {
          Get.to(
            () => CourseDetail(
              course: course,
            ),
          );
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
              FutureBuilder<List<ReviewModel>>(
                future: reviewsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    List<ReviewModel> reviews = snapshot.data!;
                    return OverallCourseReview(reviews: reviews);
                  } else {
                    return const Text('No reviews available.');
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                controller.count.toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                height: 400,
                child: UserReviewCard(
                  courseName: course.title, limit: false,
                ),
              ),
              const SizedBox(height: 10,),
              Center(
                child: ElevatedButton(
                  style:  ButtonStyle(backgroundColor : MaterialStateProperty.all<Color>(Colors.purple),),
                  onPressed: () {},
                  child: Text(
                    "Write A Review",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(color: Colors.white),
                  ),
                ),
              ),
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
    required this.reviews,
  });

  final List<ReviewModel> reviews;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReviewAndRatingController());
    final averageRating = controller.averageRating;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                averageRating.toString(),
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  RatingProgressIndicator(
                    text: '5',
                    count: controller.fiveStar.toDouble(),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  RatingProgressIndicator(
                      text: '4', count: controller.fourStar.toDouble()),
                  const SizedBox(
                    height: 4,
                  ),
                  RatingProgressIndicator(
                      text: '3', count: controller.threeStar.toDouble()),
                  const SizedBox(
                    height: 4,
                  ),
                  RatingProgressIndicator(
                      text: '2', count: controller.twoStar.toDouble()),
                  const SizedBox(
                    height: 4,
                  ),
                  RatingProgressIndicator(
                      text: '1', count: controller.oneStar.toDouble()),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        RatingBarIndicator(
          rating: averageRating.value,
          itemSize: 20,
          unratedColor: Colors.grey,
          itemBuilder: (_, __) => const Icon(
            Iconsax.star1,
            color: Colors.purple,
          ),
        ),
      ],
    );
  }
}

class RatingProgressIndicator extends StatelessWidget {
  const RatingProgressIndicator({
    super.key,
    required this.text,
    required this.count,
  });

  final String text;
  final double count;

  @override
  Widget build(BuildContext context) {
    final controller = ReviewAndRatingController.instance;
    final totalReviews = controller.count.value;
    final totalRatings = controller.oneStar.value +
        controller.twoStar.value +
        controller.threeStar.value +
        controller.fourStar.value +
        controller.fiveStar.value;
    print(totalRatings);
    print(totalReviews);
    final percentage = totalRatings > 0 ? count / totalRatings : 0.0;

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
              value: percentage,
              minHeight: 25,
              backgroundColor: Colors.grey,
              borderRadius: BorderRadius.circular(7),
              valueColor: const AlwaysStoppedAnimation(Colors.purple),
            ),
          ),
        ),
      ],
    );
  }
}
