import 'package:e_com_app/common/widgets/products/cart/add_remove_button.dart';
import 'package:e_com_app/common/widgets/products/cart/cart_item.dart';
import 'package:e_com_app/common/widgets/texts/product_price_text.dart';
import 'package:e_com_app/features/shop/controller/product/cart_controller.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ECartItems extends StatelessWidget {
  const ECartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        itemCount: cartController.cartItems.length,
        separatorBuilder: (_, __) => const SizedBox(height: ESizes.spaceBtwSections),
        itemBuilder: (_, index) => Obx(
          () {
            final item = cartController.cartItems[index];
            return Column(
              children: [
                ///--cart item
                TCartItem(cartItem: item),
                if(showAddRemoveButtons) const SizedBox(height: ESizes.spaceBtwItems),

                ///--add remove row with total price
                if(showAddRemoveButtons)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ///--extra space
                          const SizedBox(width: 70),

                          ///--add remove icon
                          EProductQuantityWithAddRemoveButton(
                            quantity: item.quantity,
                            add: () => cartController.addOneToCart(item),
                            remove: () => cartController.removeOneFromCart(item),
                          ),
                        ],
                      ),

                      ///-- product total price
                      EProductPriceText(price: (item.price * item.quantity).toStringAsFixed(1)),
                    ],
                  ),
              ],
            );
          }
        ),
      ),
    );
  }
}
