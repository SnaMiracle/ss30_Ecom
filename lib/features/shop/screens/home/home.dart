import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com_app/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:e_com_app/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:e_com_app/common/widgets/layouts/grid_layout.dart';
import 'package:e_com_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:e_com_app/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:e_com_app/common/widgets/texts/section_heading.dart';
import 'package:e_com_app/features/shop/controller/product/product_controller.dart';
import 'package:e_com_app/features/shop/screens/all_products/all_products.dart';
import 'package:e_com_app/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'widgets/home_categories.dart';
import 'widgets/promo_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///--header
            const EPrimaryHeaderContainer(
              child: Column(
                children: [
                  ///---appbar
                  EHomeAppBar(),
                  SizedBox(height: ESizes.spaceBtwSections),

                  ///--searchbar
                  ESearchContainer(text: 'Search in Store'),
                  SizedBox(height: ESizes.spaceBtwSections),

                  ///--categories
                  Padding(
                    padding: EdgeInsets.only(left: ESizes.defaultSpace),
                    child: Column(
                      children: [
                        ESectionHeading(title: 'Popular Categories', showActionButton: false, textColor: Colors.white),
                        SizedBox(height: ESizes.spaceBtwItems),


                        EHomeCategories(),
                      ],
                    ),
                  ),
                  SizedBox(height: ESizes.spaceBtwSections),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(ESizes.defaultSpace),
              child: Column(
                children: [

                  const EPromoSlider(),
                  const SizedBox(height: ESizes.spaceBtwSections),

                  ESectionHeading(
                    title: 'Popular Products',
                    onPressed: () => Get.to(
                          () => AllProducts(
                            title: 'Popular Products',
                            futureMethod: controller.fetchAllFeaturedProducts(),
                      ),
                    ),
                  ),
                  const SizedBox(height: ESizes.spaceBtwItems),
                  
                  Obx((){
                    if(controller.isLoading.value) return const EVerticalProductShimmer();

                    if(controller.featuredProducts.isEmpty) {
                      return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
                    }
                    return EGridLayout(
                        itemCount: controller.featuredProducts.length,
                        itemBuilder:(_, index) => EProductCardVertical(product: controller.featuredProducts[index])
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




