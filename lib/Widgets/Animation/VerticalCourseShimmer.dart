import 'package:dummy1/Widgets/Animation/shimmer.dart';
import 'package:dummy1/Widgets/GridLayout/GridLayout.dart';
import 'package:flutter/material.dart';

class VerticalCourseShimmer extends StatelessWidget {
  const VerticalCourseShimmer({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridLayout(
      itemCount: itemCount,
      itemBuilder: (_, __) => const SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerEffect(width: 180, height: 180),
            SizedBox(
              height: 32,
            ),
            ShimmerEffect(width: 160, height: 15),
            SizedBox(
              height: 16,
            ),
            ShimmerEffect(width: 110, height: 15),

          ],
        ),
      ),
    );
  }
}
