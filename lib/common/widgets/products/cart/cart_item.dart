import 'package:e_com_app/common/widgets/texts/e_brand_title_text_with_verified_icon.dart';
import 'package:e_com_app/common/widgets/texts/product_title_text.dart';
import 'package:e_com_app/features/shop/models/cart_item_model.dart';
import 'package:e_com_app/util/constants/colors.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../images/e_rounded_image.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key, required this.cartItem,
  });

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ///--images
        ERoundedImage(
          imageUrl: cartItem.image ?? '',
          width: 60,
          height: 60,
          isNetworkImage: true,
          padding: const EdgeInsets.all(ESizes.sm),
          backgroundColor: EHelperFunctions.isDarkMode(context) ? EColors.darkerGrey : EColors.light,
        ),
        const SizedBox(width: ESizes.spaceBtwItems),

        ///--title price size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EBrandTitleWithVerifiedIcon(title: cartItem.brandName ?? ''),
              Flexible(child: EProductTitleText(title: cartItem.title, maxLines: 1)),

              ///--attribute
              Text.rich(
                  TextSpan(
                    children: (cartItem.selectedVariation ?? {})
                        .entries
                        .map(
                            (e) => TextSpan(
                                children: [
                                  TextSpan(text: ' ${e.key} ', style: Theme.of(context).textTheme.bodySmall),
                                  TextSpan(text: ' ${e.value} ', style: Theme.of(context).textTheme.bodyLarge),
                              ],
                            ),
                    ).toList(),
                  )
              )
            ],
          ),
        )
      ],
    );
  }
}