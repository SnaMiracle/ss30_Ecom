import 'package:e_com_app/common/widgets/texts/section_heading.dart';
import 'package:e_com_app/features/shop/models/product_model.dart';
import 'package:e_com_app/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:e_com_app/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:e_com_app/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:e_com_app/util/constants/enums.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import 'widgets/button_add_to_cart.dart';
import 'widgets/product_detail_image_slider.dart';
import 'widgets/rating_share_widget.dart';
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: EButtonAddToCart(product: product),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///-- product slider
            EProductImageSlider(product: product),

            ///-- product detail
            Padding(
              padding: const EdgeInsets.only(right: ESizes.defaultSpace, left: ESizes.defaultSpace, bottom: ESizes.defaultSpace),
              child: Column(
                children: [
                  ///-- rating
                  const ERatingAndShare(),

                  ///-- price
                  EProductMetaData(product: product),

                  ///-- attribute
                  if(product.productType == ProductType.variable.toString()) EProductAttributes(product: product),
                  if(product.productType == ProductType.variable.toString()) const SizedBox(height: ESizes.spaceBtwSections),

                  ///-- checkout
                  SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){}, child: const Text('Checkout'))),
                  const SizedBox(height: ESizes.spaceBtwSections),
                  ///--description
                  const ESectionHeading(title: 'Description', showActionButton: false),
                  const SizedBox(height: ESizes.spaceBtwItems),
                  ReadMoreText(
                    product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Less',
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  ///-- review
                  const Divider(),
                  const SizedBox(height: ESizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ESectionHeading(title: 'Reviews (199)', showActionButton: false,),
                      IconButton(icon: const Icon(Iconsax.arrow_right_3, size: 18), onPressed: () => Get.to(() => const ProductReviewScreen())),
                    ],
                  ),
                  const SizedBox(height: ESizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




