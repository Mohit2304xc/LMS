import 'package:dummy1/Controller/RatingAndReviewController.dart';
import 'package:dummy1/Model/CourseModel.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:share_plus/share_plus.dart';

class ReviewandRating extends StatelessWidget {
  const ReviewandRating({
    super.key, required this.course,
  });

  final CourseModel course;

  void _shareCourseDetail(BuildContext context, CourseModel course) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final String text = 'Check out this course: ${course.title}\n\nDescription: ${course.description ?? ''}';
    Share.share(text,subject: "Course Details: ${course.title}",sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }


  @override
  Widget build(BuildContext context) {
    final controller = ReviewAndRatingController.instance;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Iconsax.star5,
              color: Colors.amber,
              size: 24,
            ),
            const SizedBox(
              width: 8,
            ),
            Text.rich(
              TextSpan(
                  text: controller.count.toString(),
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
            const SizedBox(
              width: 4,
            ),
            Text.rich(
              TextSpan(text: "${controller.averageRating}"),
            )
          ],
        ),
        IconButton(
          onPressed: () {
            _shareCourseDetail(context, course);
          },
          icon: const Icon(
            Icons.share,
            size: 16,
          ),
        ),
      ],
    );
  }
}
