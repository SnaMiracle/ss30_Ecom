import 'package:e_com_app/common/widgets/icons/e_circular_icon.dart';
import 'package:e_com_app/features/shop/controller/product/favourites_controller.dart';
import 'package:e_com_app/util/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EFavouriteIcon extends StatelessWidget {
  const EFavouriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Obx(
            () => ECircularIcon(
              icon: controller.isFavourite(productId) ? Iconsax.heart5 : Iconsax.heart,
              color: controller.isFavourite(productId) ? EColors.error : null,
              onPressed: () => controller.toggleFavouriteProduct(productId),
            ),
    );
  }
}
