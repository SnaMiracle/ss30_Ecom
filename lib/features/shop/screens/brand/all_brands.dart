import 'package:e_com_app/common/widgets/appbar/appbar.dart';
import 'package:e_com_app/common/widgets/brands/brand_card.dart';
import 'package:e_com_app/common/widgets/layouts/grid_layout.dart';
import 'package:e_com_app/common/widgets/products/sortable/sortable_products.dart';
import 'package:e_com_app/common/widgets/shimmers/brands_shimmer.dart';
import 'package:e_com_app/common/widgets/texts/section_heading.dart';
import 'package:e_com_app/features/shop/controller/brand_controller.dart';
import 'package:e_com_app/features/shop/models/brand_model.dart';
import 'package:e_com_app/features/shop/screens/brand/brand_products.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;

    return Scaffold(
      appBar: const EAppBar(title: Text('Brand'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              ///--heading
              const ESectionHeading(title: 'Brands', showActionButton: false),
              const SizedBox(height: ESizes.spaceBtwItems),

              ///--brands
              Obx(
                    () {
                      if (brandController.isLoading.value) return const EBrandsShimmer();

                      if (brandController.allBrands.isEmpty) {
                        return Center(child:  Text('No Data Found.', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
                      }

                  return EGridLayout(itemCount: brandController.allBrands.length,
                    mainAxisExtent: 80,
                    itemBuilder: (_, index) {
                      final brand = brandController.allBrands[index];

                      return EBrandCard(showBorder: true, brand: brand,
                        onTap: () => Get.to(() => BrandProducts(brand: brand)),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
