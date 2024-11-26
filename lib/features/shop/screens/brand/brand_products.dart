import 'package:e_com_app/common/widgets/appbar/appbar.dart';
import 'package:e_com_app/common/widgets/brands/brand_card.dart';
import 'package:e_com_app/common/widgets/products/sortable/sortable_products.dart';
import 'package:e_com_app/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:e_com_app/features/shop/controller/brand_controller.dart';
import 'package:e_com_app/features/shop/models/brand_model.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: EAppBar(title: Text(brand.name), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              EBrandCard(showBorder: true, brand: brand),
              const SizedBox(height: ESizes.spaceBtwSections),

              FutureBuilder(
                future: controller.getBrandProducts(brandId: brand.id),
                builder: (context, snapshot) {
                  
                  const loader = EVerticalProductShimmer();
                  final widget = ECloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;

                  final brandProducts = snapshot.data!;
                  return ESortableProducts(products: brandProducts);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
