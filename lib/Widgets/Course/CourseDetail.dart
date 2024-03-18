import 'package:dummy1/Model/CourseModel.dart';
import 'package:dummy1/Widgets/ReviewandRating/CourseReview.dart';
import 'package:dummy1/Widgets/ReviewandRating/UserReviewCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dummy1/Widgets/BottomNavigation/BottomAddToCart.dart';
import 'package:dummy1/Widgets/Course/CourseMetaData.dart';
import 'package:dummy1/Widgets/SectionHeading/SectionHeading.dart';
import 'package:readmore/readmore.dart';

import '../../Controller/RatingAndReviewController.dart';
import '../../Model/ReviewModel.dart';
import '../../Screen/checkOut.dart';
import '../ReviewandRating/ReviewAndRatings.dart';
import 'CourseDescriptionImageDetails.dart';

class CourseDetail extends StatelessWidget {
  const CourseDetail({super.key, required this.course});

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReviewAndRatingController());
    final reviewsFuture = controller.fetchReviewAndRating(course.title);
    final fewReviews = controller.fetchFewReviewAndRating(course.title);
    return Scaffold(
      bottomNavigationBar: BottomAddToCart(
        course: course,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CourseDecriptionImageDetails(
              course: course,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24, left: 24, bottom: 24),
              child: Column(
                children: [
                  ReviewandRating(course: course),
                  CourseMetaData(course: course),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => const CheckoutScreen());
                      },
                      child: const Text("CheckOut"),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const SectionHeading(
                    title: "Description",
                    showActionButton: false,
                    textColor: Colors.black,
                  ),
                  ReadMoreText(CourseModel.getDescriptionWithoutPTags(course.description ?? '')),
                  const Divider(),
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
                        int totalReviews = reviews.length;
                        return SectionHeading(
                          title: "Reviews ($totalReviews)",
                          showActionButton: true,
                          textColor: Colors.black,
                          onPressed: () {
                            Get.to(CourseReview(course: course));
                          },
                        );
                      } else {
                        return const Text('No reviews available.');
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                      height: 300,
                      child: UserReviewCard(courseName: course.title, limit: true,)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
