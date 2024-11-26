import 'package:e_com_app/features/shop/controller/product/cart_controller.dart';
import 'package:e_com_app/features/shop/models/product_model.dart';
import 'package:e_com_app/features/shop/screens/product_details/product_detail.dart';
import 'package:e_com_app/util/constants/colors.dart';
import 'package:e_com_app/util/constants/enums.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductCartAddToCartButton extends StatelessWidget {
  const ProductCartAddToCartButton({
    super.key, required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return InkWell(
      onTap: () {
        if(product.productType == ProductType.single.toString()) {
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);
        } else {
          Get.to(() => ProductDetailScreen(product: product));
        }
      },
      child: Obx(() {
          final productQuantityInCart = cartController.getProductQuantityInCart(product.id);
          return Container(
            decoration: BoxDecoration(
              color: productQuantityInCart > 0 ? EColors.primary : EColors.dark,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(ESizes.cardRadiusMd),
                bottomRight: Radius.circular(ESizes.productImageRadius),
            ),
          ),
          child: SizedBox(
            width: ESizes.iconLg * 1.2,
            height: ESizes.iconLg * 1.2,
            child: Center(
                child: productQuantityInCart > 0 
                    ? Text(productQuantityInCart.toString(), style: Theme.of(context).textTheme.bodyLarge!.apply(color: EColors.white))
                    : const Icon(Iconsax.add, color: EColors.white),
            ),
          ),
        );
      }),
    );
  }
}