
import 'package:dummy1/Controller/RatingAndReviewController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../Model/CourseModel.dart';
import '../../Model/ReviewModel.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key, required this.courseName, required this.limit});

  final String courseName;
  final bool limit;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReviewAndRatingController());
    final reviewsFuture = controller.fetchReviewAndRating(courseName);
    final reviews = controller.fetchFewReviewAndRating(courseName);
    if (limit == true) {
      return FutureBuilder<List<ReviewModel>>(
        future: reviews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<ReviewModel> reviews = snapshot.data!;
            return ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                ReviewModel review = reviews[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(backgroundImage: AssetImage(
                            "assets/images/profile/download (1).png")),
                        const SizedBox(width: 16),
                        Text(review.name, style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: review.rating.toDouble(),
                          itemSize: 20,
                          unratedColor: Colors.grey,
                          itemBuilder: (_, __) =>
                          const Icon(
                            Iconsax.star1,
                            color: Colors.purple,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(review.date.toString(), style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ReadMoreText(CourseModel.getDescriptionWithoutPTags(review.review)),
                    const SizedBox(height: 16),
                    const Divider(),
                  ],
                );
              },
            );
          } else {
            return const Center(child: Text('No reviews available.'));
          }
        },
      );
    } else {
      return FutureBuilder<List<ReviewModel>>(
        future: reviewsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<ReviewModel> reviews = snapshot.data!;
            return ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                ReviewModel review = reviews[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(backgroundImage: AssetImage(
                            "assets/images/profile/download (1).png")),
                        const SizedBox(width: 16),
                        Text(review.name, style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: review.rating.toDouble(),
                          itemSize: 20,
                          unratedColor: Colors.grey,
                          itemBuilder: (_, __) =>
                          const Icon(
                            Iconsax.star1,
                            color: Colors.purple,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(review.date.toString(), style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ReadMoreText(review.review),
                    const SizedBox(height: 16),
                    const Divider(),
                  ],
                );
              },
            );
          } else {
            return const Center(child: Text('No reviews available.'));
          }
        },
      );
    }
  }
}
