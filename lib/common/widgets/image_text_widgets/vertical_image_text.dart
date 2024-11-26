import 'package:e_com_app/common/widgets/images/e_circular_image.dart';
import 'package:flutter/material.dart';

class EVerticalImageText extends StatelessWidget {
  const EVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = Colors.white,
    this.backgroundColor,
    this.onTap,
    this.isNetworkImage = true,
    this.textWidth = 70.0, // Default dynamic width
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  final bool isNetworkImage;
  final double textWidth;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0), // Adjusted spacing
        child: Column(
          children: [
            ECircularImage(
              image: image,
              fit: BoxFit.fill,
              padding: 10,
              isNetworkImage: isNetworkImage,
              backgroundColor: backgroundColor ?? (isDarkMode ? Colors.black : Colors.white),
              overlayColor: isDarkMode ? Colors.white : Colors.black,
            ),
            const SizedBox(height: 8.0), // Adjusted spacing
            SizedBox(
              width: textWidth,
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(color: textColor),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
