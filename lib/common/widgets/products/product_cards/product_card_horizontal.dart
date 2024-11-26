import 'package:e_com_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_com_app/common/widgets/images/e_rounded_image.dart';
import 'package:e_com_app/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:e_com_app/common/widgets/texts/e_brand_title_text_with_verified_icon.dart';
import 'package:e_com_app/common/widgets/texts/product_price_text.dart';
import 'package:e_com_app/common/widgets/texts/product_title_text.dart';
import 'package:e_com_app/features/shop/controller/product/product_controller.dart';
import 'package:e_com_app/features/shop/models/product_model.dart';
import 'package:e_com_app/features/shop/screens/product_details/product_detail.dart';
import 'package:e_com_app/util/constants/colors.dart';
import 'package:e_com_app/util/constants/enums.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EProductCardHorizontal extends StatelessWidget {
  const EProductCardHorizontal({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);

    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product,)),
      child: Container(
        width: 310,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ESizes.productImageRadius),
          color: dark ? EColors.darkerGrey : EColors.softGrey,
        ),
        child: Row(
          children: [
            ///--thumbnail
            ERoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(ESizes.sm),
              backgroundColor: dark ? EColors.darkerGrey : EColors.light,
              child: Stack(
                children: [
                  ///--thumbnail image
                  SizedBox(
                      height: 120,
                      width: 120,
                      child: ERoundedImage(imageUrl: product.thumbnail, applyImageRadius: true, isNetworkImage: true),
                  ),

                  ///--sale tag
                  if (salePercentage != null)
                    Positioned(
                      top: 12,
                        child: ERoundedContainer(
                          radius: ESizes.sm,
                          backgroundColor: EColors.secondary.withOpacity(0.8),
                          padding: const EdgeInsets.symmetric(horizontal: ESizes.sm, vertical: ESizes.xs),
                          child: Text('$salePercentage%', style: Theme.of(context).textTheme.labelLarge!.apply(color: EColors.black)),
                        ),
                    ),

                  ///--favorite icon
                  Positioned(
                    top: 0,
                    right: 0,
                    child: EFavouriteIcon(productId: product.id),
                  ),
                ],
              ),
            ),

            ///--detail
            SizedBox(
              width: 172,
              child: Padding(
                padding: const EdgeInsets.only(top: ESizes.sm, left: ESizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EProductTitleText(title: product.title, smallSize: true),
                        const SizedBox(height: ESizes.spaceBtwItems / 2),
                        EBrandTitleWithVerifiedIcon(title: product.brand!.name),
                      ],
                    ),

                    const Spacer(),

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

                        Container(
                          decoration: const BoxDecoration(
                            color: EColors.dark,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(ESizes.cardRadiusMd),
                              bottomRight: Radius.circular(ESizes.productImageRadius),
                            ),
                          ),
                          child: const SizedBox(
                            width: ESizes.iconLg * 1.2,
                            height: ESizes.iconLg * 1.2,
                            child: Center(child: Icon(Iconsax.add, color: EColors.white)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}