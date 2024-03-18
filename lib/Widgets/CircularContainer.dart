import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    super.key,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.padding,
    this.child,
    this.backgroundColor = Colors.white, this.margin, this.onTap,
  });

  final double? width, height;
  final VoidCallback? onTap;
  final double radius;
  final EdgeInsets? margin,padding;
  final Widget? child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        padding:  padding,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: backgroundColor
        ),
        child: child,
      ),
    );
  }
}
