import 'package:e_com_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_com_app/common/widgets/images/e_circular_image.dart';
import 'package:e_com_app/common/widgets/texts/e_brand_title_text_with_verified_icon.dart';
import 'package:e_com_app/common/widgets/texts/product_price_text.dart';
import 'package:e_com_app/common/widgets/texts/product_title_text.dart';
import 'package:e_com_app/features/shop/controller/product/product_controller.dart';
import 'package:e_com_app/features/shop/models/product_model.dart';
import 'package:e_com_app/util/constants/colors.dart';
import 'package:e_com_app/util/constants/enums.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class EProductMetaData extends StatelessWidget {
  const EProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);
    final darkMode = EHelperFunctions.isDarkMode(context);
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///-- price
        Row(
          children: [
            ///-- sale tag
            ERoundedContainer(
              radius: ESizes.sm,
              backgroundColor: EColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(horizontal: ESizes.sm, vertical: ESizes.xs),
              child: Text('$salePercentage%', style: Theme.of(context).textTheme.labelLarge!.apply(color: EColors.black)),
            ),
            const SizedBox(width: ESizes.spaceBtwItems),

            ///-- price
            if (product.productType == ProductType.single.toString() && product.salePrice > 0)
              Text('\$${product.price}', style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough)),
            if (product.productType == ProductType.single.toString() && product.salePrice > 0) const SizedBox(width: ESizes.spaceBtwItems),
            EProductPriceText(price: controller.getProductPrice(product), isLarge: true),
          ],
        ),
        const SizedBox(height: ESizes.spaceBtwItems / 1.5),

        ///-- title
        EProductTitleText(title: product.title),
        const SizedBox(height: ESizes.spaceBtwItems / 1.5),

        ///-- stock status
        Row(
          children: [
            const EProductTitleText(title: 'Status'),
            const SizedBox(width: ESizes.spaceBtwItems),
            Text(controller.getProductStockStatus(product.stock), style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: ESizes.spaceBtwItems / 1.5),

        ///-- brand
        Row(
          children: [
            ECircularImage(
              image: product.brand != null ? product.brand!.image : '',
              isNetworkImage: true,
              width: 32, height: 32, overlayColor: darkMode ? EColors.white : EColors.black,
            ),
            EBrandTitleWithVerifiedIcon(title: product.brand != null ? product.brand!.name : '', brandTextSize: TextSizes.medium),
          ],
        ),
      ],
    );
  }
}
