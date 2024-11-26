import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_com_app/common/widgets/shimmers/shimmer.dart';
import 'package:e_com_app/util/constants/colors.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class ERoundedImage extends StatelessWidget {
  const ERoundedImage({
    super.key,
    this.border,
    this.padding,
    this.onPressed,
    this.width,
    this.height,
    this.applyImageRadius = true,
    required this.imageUrl,
    this.fit = BoxFit.contain,
    this.backgroundColor,
    this.isNetworkImage = false,
    this.borderRadius = ESizes.md,

  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius; 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(border: border, color: backgroundColor, borderRadius: BorderRadius.circular(borderRadius)),
          child: ClipRRect(
            borderRadius: applyImageRadius ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
             child: isNetworkImage
                 ? CachedNetworkImage(
                     fit: fit,
                     imageUrl: imageUrl,
                     progressIndicatorBuilder: (context, url, downloadProgress) =>
                        EShimmerEffect(width: width ?? double.infinity, height: height ?? 158),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                  )
                 : Image(
                      fit: fit,
                      image: AssetImage(imageUrl),
             ),
        ),
      ),
    );
  }
}