import 'package:e_com_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_com_app/common/widgets/images/e_circular_image.dart';
import 'package:e_com_app/features/shop/models/brand_model.dart';
import 'package:e_com_app/util/constants/colors.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../util/constants/enums.dart';
import '../../../util/constants/sizes.dart';
import '../texts/e_brand_title_text_with_verified_icon.dart';

class EBrandCard extends StatelessWidget {
  const EBrandCard({
    super.key,
    this.onTap,
    required this.showBorder, required this.brand,
  });

  final BrandModel brand;
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = EHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: ERoundedContainer(
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(ESizes.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///--icon
            Flexible(
              child: ECircularImage(
                isNetworkImage: true,
                image: brand.image,
                backgroundColor: Colors.transparent,
                overlayColor: isDark ? EColors.white : EColors.black,
              ),
            ),
            const SizedBox(width: ESizes.spaceBtwItems / 2),

            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EBrandTitleWithVerifiedIcon(title: brand.name, brandTextSize:  TextSizes.large),
                  Text(
                    '${brand.productsCount ?? 0} products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}