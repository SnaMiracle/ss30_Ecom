import 'package:e_com_app/common/widgets/brands/brand_show_case.dart';
import 'package:e_com_app/common/widgets/layouts/grid_layout.dart';
import 'package:e_com_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:e_com_app/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:e_com_app/common/widgets/texts/section_heading.dart';
import 'package:e_com_app/features/shop/controller/category_controller.dart';
import 'package:e_com_app/features/shop/models/category_model.dart';
import 'package:e_com_app/features/shop/models/product_model.dart';
import 'package:e_com_app/features/shop/screens/all_products/all_products.dart';
import 'package:e_com_app/features/shop/screens/store/widgets/category_brands.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ECategoryTab extends StatelessWidget {
  const ECategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [

              CategoryBrands(category: category),
              const SizedBox(height: ESizes.spaceBtwItems),

              FutureBuilder(
                future: controller.getCategoryProducts(categoryId: category.id),
                builder: (context, snapshot) {

                  final response = ECloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: const EVerticalProductShimmer());
                  if (response != null) return response;

                  final products = snapshot.data!;

                  return Column(
                    children: [
                      ESectionHeading(title: 'You Might Like',
                          onPressed: () => Get.to(AllProducts(
                            title: category.name,
                            futureMethod: controller.getCategoryProducts(categoryId: category.id, limit: -1),
                          ),
                        ),
                      ),
                      const SizedBox(height: ESizes.spaceBtwItems),
                      EGridLayout(itemCount: products.length, itemBuilder: (_, index) => EProductCardVertical(product: products[index])),
                    ],
                  );
                }
              ),
            ],
          ),
        ),
      ],
    );
  }
}
