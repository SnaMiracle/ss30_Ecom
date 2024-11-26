import 'package:e_com_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_com_app/common/widgets/texts/section_heading.dart';
import 'package:e_com_app/features/shop/controller/product/checkout_controller.dart';
import 'package:e_com_app/util/constants/colors.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EBillingPaymentSection extends StatelessWidget {
  const EBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    
    final dark = EHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        ESectionHeading(title: 'Payment Method', buttonTitle: 'Change', onPressed: () => controller.selectPaymentMethod(context)),
        const SizedBox(height: ESizes.spaceBtwItems),
        Obx(
          () => Row(
            children: [
              ERoundedContainer(
                width: 60,
                height: 40,
                backgroundColor: dark ? EColors.light : EColors.white,
                padding: const EdgeInsets.all(ESizes.sm),
                child: Image(image: AssetImage(controller.selectedPaymentMethod.value.image), fit: BoxFit.cover),
              ),
              const SizedBox(width: ESizes.spaceBtwItems / 2),
              Text(controller.selectedPaymentMethod.value.name, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }
}
