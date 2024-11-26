import 'package:e_com_app/common/styles/shadows.dart';
import 'package:e_com_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_com_app/common/widgets/icons/e_circular_icon.dart';
import 'package:e_com_app/common/widgets/images/e_rounded_image.dart';
import 'package:e_com_app/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:e_com_app/common/widgets/products/product_cards/add_to_cart_button.dart';
import 'package:e_com_app/common/widgets/texts/e_brand_title_text_with_verified_icon.dart';
import 'package:e_com_app/common/widgets/texts/product_price_text.dart';
import 'package:e_com_app/common/widgets/texts/product_title_text.dart';
import 'package:e_com_app/features/shop/controller/product/product_controller.dart';
import 'package:e_com_app/features/shop/models/product_model.dart';
import 'package:e_com_app/features/shop/screens/product_details/product_detail.dart';
import 'package:e_com_app/util/constants/colors.dart';
import 'package:e_com_app/util/constants/enums.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EProductCardVertical extends StatelessWidget {
  const EProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = EHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product,)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [EShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(ESizes.productImageRadius),
          color: dark ? EColors.darkGrey : EColors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: ESizes.xs),
            /// --thumbnail
            ERoundedContainer(
              height: 180,
              //padding: const EdgeInsets.all(ESizes.sm),
              backgroundColor: dark ? EColors.dark : EColors.light,
              child: Stack(
                children: [
                  /// --thumbnail images
                  ERoundedImage(imageUrl: product.thumbnail, applyImageRadius: true, isNetworkImage: true),

                  /// --sale tag
                  salePercentage == 0
                      ? const SizedBox.shrink()
                      : Positioned(
                    top: 12,
                    child: ERoundedContainer(
                      radius: ESizes.sm,
                      backgroundColor: EColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(horizontal: ESizes.sm, vertical: ESizes.xs),
                      child: Text(
                        '${salePercentage?.toStringAsFixed(0)}%',
                        style: Theme.of(context).textTheme.labelLarge!.apply(color: EColors.black),
                      ),
                    ),
                  ),

                  Positioned(
                      top: 0,
                      right: 0,
                      child: EFavouriteIcon(productId: product.id),
                  ),
                ],
              ),
            ),
            const SizedBox(height: ESizes.spaceBtwItems / 2),

            /// --details
            Padding(
              padding: const EdgeInsets.only(left: ESizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft, // Ensures left alignment
                    child: EProductTitleText(
                      title: product.title,
                      smallSize: true,
                    ),
                  ),
                  const SizedBox(height: ESizes.spaceBtwItems / 2),
                  EBrandTitleWithVerifiedIcon(title: product.brand!.name),
                ],
              ),
            ),


            const Spacer(),
            //const SizedBox(height: 10),

            /// --price row
            Row(
              mainAxisAlignment:  MainAxisAlignment.spaceBetween,
              children: [

                ///--price
                Flexible(
                  child: Column(
                    children: [
                      if(product.productType == ProductType.single.toString() && product.salePrice > 0)
                        Padding(
                          padding: const EdgeInsets.only(left: ESizes.sm),
                          child: Text(
                            product.price.toString(),
                            style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough),
                          ),
                        ),

                      ///--price
                      Padding(
                        padding: const EdgeInsets.only(left: ESizes.sm),
                        child: EProductPriceText(price: controller.getProductPrice(product)),
                      ),
                    ],
                  ),
                ),

                ///--add to cart button
                ProductCartAddToCartButton(product: product,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

