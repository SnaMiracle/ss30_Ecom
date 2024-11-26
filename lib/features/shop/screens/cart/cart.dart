import 'package:e_com_app/common/widgets/appbar/appbar.dart';
import 'package:e_com_app/common/widgets/loaders/animation_loader.dart';
import 'package:e_com_app/features/shop/controller/product/cart_controller.dart';
import 'package:e_com_app/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:e_com_app/features/shop/screens/checkout/checkout.dart';
import 'package:e_com_app/navigation_menu.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Scaffold(
      appBar: EAppBar(showBackArrow: true, title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
      body: Obx(
        () {

          ///--nothing found widget
          final emptyWidget = EAnimationLoaderWidget(
              text: 'Whoops! Cart is EMPTY.',
              animation: EImages.emptyCart,
            showAction: true,
            actionText: 'Let\'s fill it',
            onActionPressed: () => Get.off(() => const NavigationMenu()),
          );

          if (controller.cartItems.isEmpty) {
            return emptyWidget;
          } else {
            return const SingleChildScrollView(
              child: Padding(
                    padding: EdgeInsets.all(ESizes.defaultSpace),
              
                    ///--item in cart
                    child: ECartItems(),
                        ),
            );
          }
        }
      ),

       ///--check out button
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox(height: 100)
          : Padding(padding: const EdgeInsets.all(ESizes.defaultSpace), child: ElevatedButton(
              onPressed: () => Get.to(() => const CheckoutScreen()),
              child: Obx(() => Text('Checkout \$${controller.totalCartPrice.value}')),
          )
      ),
    );
  }
}




