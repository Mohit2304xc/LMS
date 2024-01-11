import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(backgroundImage: AssetImage("assets/images/profile/download (1).png"),),
                const SizedBox(width: 16,),
                Text("Mohit",style: Theme.of(context).textTheme.titleLarge,)
              ],
            ),
            IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        const SizedBox(width: 16,),
        Row(
          children: [
            RatingBarIndicator(
                rating: 4,
                itemSize: 20,
                unratedColor: Colors.grey,
                itemBuilder: (_, __) => const Icon(
                  Iconsax.star1,
                  color: Colors.purple,
                )),
            Text("01 Nov 2023",style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
        const SizedBox(width: 16,),
        const ReadMoreText("Course was amazing"),
      ],
    );
  }
}
