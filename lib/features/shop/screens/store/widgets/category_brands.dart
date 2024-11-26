import 'package:e_com_app/common/widgets/brands/brand_show_case.dart';
import 'package:e_com_app/common/widgets/shimmers/boxes_shimmer.dart';
import 'package:e_com_app/common/widgets/shimmers/list_tile_shimmer.dart';
import 'package:e_com_app/features/shop/controller/brand_controller.dart';
import 'package:e_com_app/features/shop/models/category_model.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
      future: controller.getBrandsForCategory(category.id),
      builder: (context, snapshot) {

        const loader = Column(
          children: [
            EListTileShimmer(),
            SizedBox(height: ESizes.spaceBtwItems),
            EBoxesShimmer(),
            SizedBox(height: ESizes.spaceBtwItems),
          ],
        );

        final widget = ECloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
        if (widget != null) return widget;

        final brands = snapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: brands.length,
            itemBuilder: (_, index) {
            final brand = brands[index];
            return FutureBuilder(
              future: controller.getBrandProducts(brandId: brand.id, limit: 3),
              builder: (context, snapshot) {

                final widget = ECloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                if (widget != null) return widget;

                final products = snapshot.data!;

                return EBrandShowcase(brand: brand, images: products.map((e) => e.thumbnail).toList());
              }
            );
          },
        );
      }
    );
  }
}
