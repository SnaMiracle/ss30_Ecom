import 'package:e_com_app/common/widgets/appbar/appbar.dart';
import 'package:e_com_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_com_app/common/widgets/texts/section_heading.dart';
import 'package:e_com_app/features/shop/controller/product/checkout_controller.dart';
import 'package:e_com_app/navigation_menu.dart';
import 'package:e_com_app/util/constants/colors.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddBankScreen extends StatelessWidget {
  const AddBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    return Scaffold(
      appBar: EAppBar(title: Text('Add Bank Account', style: Theme.of(context).textTheme.headlineSmall), showBackArrow: true),
      body: SingleChildScrollView(

        child: Padding(padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Form(
            child: Column(
              mainAxisSize:  MainAxisSize.min,
              children: [
                TextFormField(
                    decoration: const InputDecoration(prefixIcon: Icon(Iconsax.card), labelText: 'Card Number')),
                const SizedBox(height: ESizes.spaceBtwInputFields),

                Row(
                  children: [
                    Expanded(child: TextFormField(
                      decoration: const InputDecoration(prefixIcon: Icon(Iconsax.calendar), labelText: 'Expire date'),
                    ),
                    ),
                    const SizedBox(width: ESizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(prefixIcon: Icon(Iconsax.security), labelText: 'CVV'),
                      ),
                    ),
                  ],
                ),


                const SizedBox(height: ESizes.spaceBtwInputFields),
                TextFormField(
                    decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: 'Cardholder')),
                const SizedBox(height: ESizes.defaultSpace),
                const Divider(),
                ESectionHeading(title: 'Select Bank', buttonTitle: 'Change', onPressed: () => controller.selectPaymentMethod(context)),
                Obx(
                      () => Row(
                    children: [
                      ERoundedContainer(
                        width: 60,
                        height: 40,
                        backgroundColor: EHelperFunctions.isDarkMode(context) ? EColors.light : EColors.white,
                        padding: const EdgeInsets.all(ESizes.sm),
                        child: Image(image: AssetImage(controller.selectedPaymentMethod.value.image), fit: BoxFit.cover),
                      ),
                      const SizedBox(width: ESizes.spaceBtwItems),
                      Text(controller.selectedPaymentMethod.value.name, style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
                const SizedBox(height: ESizes.spaceBtwInputFields),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.to(() => const NavigationMenu()), child: const Text('Save')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
