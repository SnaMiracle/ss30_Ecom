import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_com_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_com_app/common/widgets/shimmers/shimmer.dart';
import 'package:e_com_app/features/shop/models/brand_model.dart';
import 'package:e_com_app/features/shop/screens/brand/brand_products.dart';
import 'package:e_com_app/util/constants/colors.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'brand_card.dart';

class EBrandShowcase extends StatelessWidget {
  const EBrandShowcase({
    super.key, required this.images, required this.brand,
  });

  final BrandModel brand;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandProducts(brand: brand)),
      child: ERoundedContainer(
        showBorder: true,
        borderColor: EColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(ESizes.md),
        margin: const EdgeInsets.only(bottom: ESizes.spaceBtwItems),
        child: Column(
          children: [
            EBrandCard(showBorder: false, brand: brand),
            const SizedBox(height: ESizes.spaceBtwItems),
      
            Row(
              children: images.map((image) => brandTopProductImageWidget(image, context)).toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    return Expanded(
      child: ERoundedContainer(
        height: 100,
        padding: const EdgeInsets.all(ESizes.md),
        margin: const EdgeInsets.only(right: ESizes.sm),
        backgroundColor: EHelperFunctions.isDarkMode(context) ? EColors.darkGrey : EColors.light,
        child: CachedNetworkImage(
          fit: BoxFit.contain,
            imageUrl: image,
          progressIndicatorBuilder: (context, url, downloadProgress) => const EShimmerEffect(width: 100, height: 100),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}