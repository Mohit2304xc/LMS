import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dummy1/Widgets/Animation/shimmer.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    super.key,
    required this.image,
    this.width = 250,
    this.height = 250,
    required this.applyImageRadius,
    this.border,
    this.backgroundColor,
    this.padding,
    this.fit,
    this.onPressed,
    this.borderRadius = 100,
    this.isNetworkImage = false,
  });

  final String image;
  final double? width, height;
  final bool applyImageRadius;
  final bool isNetworkImage;
  final BoxBorder? border;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final BoxFit? fit;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: border,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: Center(
            child: isNetworkImage
                ? CachedNetworkImage(
                    imageUrl: image,
                    fit: fit,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            const ShimmerEffect(width: 55, height: 55),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : Image(
                    fit: fit,
                    image: isNetworkImage
                        ? NetworkImage(image)
                        : AssetImage(image) as ImageProvider),
          ),
        ),
      ),
    );
  }
}
