import 'package:e_com_app/common/widgets/appbar/appbar.dart';
import 'package:e_com_app/common/widgets/appbar/tabbar.dart';
import 'package:e_com_app/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:e_com_app/common/widgets/custom_shapes/containers/search_page.dart';
import 'package:e_com_app/common/widgets/layouts/grid_layout.dart';
import 'package:e_com_app/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:e_com_app/common/widgets/shimmers/brands_shimmer.dart';
import 'package:e_com_app/common/widgets/texts/section_heading.dart';
import 'package:e_com_app/features/shop/controller/category_controller.dart';
import 'package:e_com_app/features/shop/controller/brand_controller.dart';
import 'package:e_com_app/features/shop/screens/brand/all_brands.dart';
import 'package:e_com_app/features/shop/screens/brand/brand_products.dart';
import 'package:e_com_app/features/shop/screens/store/widgets/category_tab.dart';
import 'package:e_com_app/util/constants/colors.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/brands/brand_card.dart';



class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final categories = CategoryController.instance.featuredCategories;

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: EAppBar(
          title: Text('Store', style: Theme.of(context).textTheme.headlineMedium),
          actions: const [
            ECartCounterIcon(counterBgColor : EColors.black, counterTextColor: EColors.white),
          ],
        ),
        body: NestedScrollView(
            headerSliverBuilder: (_, innerBoxUIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: 440,
              automaticallyImplyLeading: false,
              backgroundColor: EHelperFunctions.isDarkMode(context) ? EColors.black : EColors.white,
      
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(ESizes.defaultSpace),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const SizedBox(height: ESizes.spaceBtwItems),
                    ESearchContainer(text: 'Search in Store', showBorder: true, showBackground: false, padding: EdgeInsets.zero, onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SearchPage()),
                      );
                    },),
                    const SizedBox(height: ESizes.spaceBtwSections),
      
                    ESectionHeading(title: 'Feature Brands', onPressed: () => Get.to(() => const AllBrandsScreen())),
                    const SizedBox(height: ESizes.spaceBtwItems / 1.5),
                    
                    Obx(
                      () {
                        if (brandController.isLoading.value) return const EBrandsShimmer();

                        if (brandController.featuredBrands.isEmpty) {
                          return Center(
                            child:  Text('No Data Found.', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
                        }

                        return EGridLayout(
                          itemCount: brandController.featuredBrands.length,
                          mainAxisExtent: 80,
                          itemBuilder: (_, index) {
                          final brand = brandController.featuredBrands[index];

                          return EBrandCard(showBorder: true, brand: brand, onTap: () => Get.to(() => BrandProducts(brand: brand)));
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),

              bottom: ETabBar(
                  tabs: categories.map((category) => Tab(child: Text(category.name))).toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: categories.map((category) => ECategoryTab(category: category)).toList()
        ),
      ),
      ),
    );
  }
}




