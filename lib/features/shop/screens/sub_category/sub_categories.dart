import 'package:e_com_app/common/widgets/appbar/appbar.dart';
import 'package:e_com_app/common/widgets/images/e_rounded_image.dart';
import 'package:e_com_app/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:e_com_app/common/widgets/shimmers/horizontal_product_shimmer.dart';
import 'package:e_com_app/common/widgets/texts/section_heading.dart';
import 'package:e_com_app/features/shop/controller/category_controller.dart';
import 'package:e_com_app/features/shop/models/category_model.dart';
import 'package:e_com_app/features/shop/screens/all_products/all_products.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: EAppBar(title: Text(category.name), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              ///--banner
              const ERoundedImage(width: double.infinity, imageUrl: EImages.promotionBanner1, applyImageRadius: true),
              const SizedBox(height: ESizes.spaceBtwSections),

              ///--sub category
              FutureBuilder(
                future: controller.getSubCategories(category.id),
                builder: (context, snapshot) {

                  const loader = EHorizontalProductShimmer();
                  final widget = ECloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;

                  final subCategories = snapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                      itemCount: subCategories.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {

                      final subCategory = subCategories[index];

                        return FutureBuilder(
                          future: controller.getCategoryProducts(categoryId: subCategory.id),
                          builder: (context, snapshot) {

                            final widget = ECloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                            if (widget != null) return widget;

                            final products = snapshot.data!;

                            return Column(
                              children: [
                                ///--heading
                                ESectionHeading(
                                    title: subCategory.name,
                                    onPressed: () => Get.to(
                                        () => AllProducts(
                                          title: subCategory.name,
                                          futureMethod: controller.getCategoryProducts(categoryId: subCategory.id, limit: -1),
                                        ),
                                    ),
                                ),
                                const SizedBox(height: ESizes.spaceBtwItems / 2),

                                SizedBox(
                                  height: 120,
                                  child: ListView.separated(
                                    itemCount: products.length,
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (context, index) => const SizedBox(width: ESizes.spaceBtwItems),
                                    itemBuilder: (context, index) => EProductCardHorizontal(product: products[index]),
                                  ),
                                ),

                                const SizedBox(height: ESizes.spaceBtwSections),
                              ],
                            );
                          }
                        );
                      },
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
