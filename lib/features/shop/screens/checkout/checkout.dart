import 'package:e_com_app/common/widgets/appbar/appbar.dart';
import 'package:e_com_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_com_app/common/widgets/loaders/loaders.dart';
import 'package:e_com_app/common/widgets/products/cart/coupon_widget.dart';
import 'package:e_com_app/features/shop/controller/product/cart_controller.dart';
import 'package:e_com_app/features/shop/controller/product/order_controller.dart';
import 'package:e_com_app/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:e_com_app/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:e_com_app/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:e_com_app/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:e_com_app/util/constants/colors.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/helpers/helper_functions.dart';
import 'package:e_com_app/util/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount = EPricingCalculator.calculateTotalPrice(subTotal, 'US');

    final dark = EHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: EAppBar(showBackArrow: true, title: Text('Order Review', style: Theme.of(context).textTheme.headlineSmall)),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              const ECartItems(showAddRemoveButtons: false),
              const SizedBox(height: ESizes.spaceBtwSections),

              ///--coupon text field
              const ECouponCode(),
              const SizedBox(height: ESizes.spaceBtwSections),

              ///--bill section
              ERoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(ESizes.md),
                backgroundColor: dark ? EColors.black : EColors.white,
                child: const Column(
                  children: [
                    ///---pricing
                    EBillingAmountSection(),
                    SizedBox(height: ESizes.spaceBtwItems),
                    ///--divider
                    Divider(),
                    SizedBox(height: ESizes.spaceBtwItems),

                    ///--payment method
                    EBillingPaymentSection(),
                    SizedBox(height: ESizes.spaceBtwItems),

                    ///--address
                    EBillingAddressSection()
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      ///--check out button
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
        child: ElevatedButton(
            onPressed: subTotal > 0
                ? () => orderController.processOrder(totalAmount)
                : () => ELoaders.warningSnackBar(title: 'Empty Cart', message: 'Add items in the cart in order to proceed.'),
            child: Text('Checkout \$$totalAmount'),
        ),
      ),
    );
  }
}


