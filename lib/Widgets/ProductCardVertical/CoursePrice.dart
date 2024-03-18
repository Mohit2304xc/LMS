
import 'package:flutter/material.dart';

class CoursePriceText extends StatelessWidget {
  const CoursePriceText(
      {super.key,
      this.currencySign = '£',
      required this.price,
      this.maxLines = 1,
      this.isLarge = false,
      this.lineThrough = false});

  final String currencySign;
  final int maxLines;
  final String price;
  final bool isLarge, lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      currencySign + price,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.headlineMedium!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null)
          : Theme.of(context).textTheme.titleLarge!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null),
    );
  }
}
