import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_com_app/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_com_app/common/widgets/images/e_rounded_image.dart';
import 'package:e_com_app/common/widgets/shimmers/shimmer.dart';
import 'package:e_com_app/features/shop/controller/banner_controller.dart';
import 'package:e_com_app/features/shop/controller/home_controller.dart';
import 'package:e_com_app/util/constants/colors.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EPromoSlider extends StatelessWidget {
  const EPromoSlider({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());

    return Obx(
        (){
          
          if (controller.isLoading.value) return const EShimmerEffect(width: double.infinity, height: 190);
          
          if (controller.banners.isEmpty) {
            return const Center(child: Text('No Data Found!'));
          } else {
            return Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(viewportFraction: 1, onPageChanged: (index, _) => controller.updatePageIndicator(index)),
                  items: controller.banners
                      .map(
                        (banner) => ERoundedImage(
                      imageUrl: banner.imageUrl,
                      isNetworkImage: true,
                      onPressed: () => Get.toNamed(banner.targetScreen),
                    ),
                  )
                      .toList(),
                ),
                const SizedBox(height: ESizes.spaceBtwItems),
                Center(
                  child: Obx(
                        () => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for(int i = 0; i < controller.banners.length; i++)
                          ECircularContainer(
                              width: 20,
                              height: 4,
                              margin: const EdgeInsets.only(right: 10),
                              backgroundColor: controller.carousalCurrentIndex.value == i ? EColors.primary : EColors.grey),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
    );
  }
}