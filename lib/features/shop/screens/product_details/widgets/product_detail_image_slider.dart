import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_com_app/common/widgets/appbar/appbar.dart';
import 'package:e_com_app/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:e_com_app/common/widgets/images/e_rounded_image.dart';
import 'package:e_com_app/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:e_com_app/features/shop/controller/product/images_controller.dart';
import 'package:e_com_app/features/shop/models/product_model.dart';
import 'package:e_com_app/util/constants/colors.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EProductImageSlider extends StatelessWidget {
  const EProductImageSlider({
    super.key, required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);

    return ECurvedEdgesWidget(
      child: Container(
        color: dark ? EColors.darkerGrey : EColors.light,
        child: Stack(
          children: [
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(ESizes.productImageRadius * 2),
                child: Center(child: Obx(() {
                  final image = controller.selectedProductImage.value;
                  return GestureDetector(
                    onTap: () => controller.showEnlargedImage(image),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      progressIndicatorBuilder: (_, __, downloadProgress) =>
                          CircularProgressIndicator(value: downloadProgress.progress, color: EColors.primary),
                    ),
                  );
                },
                )),
              ),
            ),

            ///--image slider
            Positioned(
              right: 0,
              bottom: 30,
              left: ESizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (_, __) => const SizedBox(width: ESizes.spaceBtwItems),
                  itemBuilder: (_, index) => Obx(
                    (){
                      final imageSelected = controller.selectedProductImage.value == images[index];
                      return ERoundedImage(
                        width: 80,
                        isNetworkImage: true,
                        imageUrl: images[index],
                        padding: const EdgeInsets.all(ESizes.sm),
                        backgroundColor: dark ? EColors.dark : EColors.white,
                        onPressed: () => controller.selectedProductImage.value = images[index],
                        border: Border.all(color: imageSelected ? EColors.primary : Colors.transparent),
                      );
                    }
                  ),
                ),
              ),
            ),

            ///-- appbar icon
            EAppBar(
              showBackArrow: true,
              actions: [
                EFavouriteIcon(productId: product.id),
              ],
            ),
          ],
        ),
      ),
    );
  }
}