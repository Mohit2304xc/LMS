import 'package:flutter/material.dart';

class CircularIcon extends StatelessWidget {
  const CircularIcon({
    super.key,
    this.icon,
    this.onPressed,
    this.width,
    this.height,
    this.backGroundColor,
  });

  final IconData? icon;
  final double? width, height;
  final VoidCallback? onPressed;
  final Color? backGroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: backGroundColor != null ? backGroundColor! : Colors.white,
          borderRadius: BorderRadius.circular(100)),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.red,
        ),
      ),
    );
  }
}
