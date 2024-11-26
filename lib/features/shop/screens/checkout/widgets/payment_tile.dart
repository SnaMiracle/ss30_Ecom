import 'package:e_com_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_com_app/features/shop/controller/product/checkout_controller.dart';
import 'package:e_com_app/features/shop/models/payment_method_model.dart';
import 'package:e_com_app/util/constants/colors.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EPaymentTile extends StatelessWidget {
  const EPaymentTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },
      leading: ERoundedContainer(
        width: 60,
        height: 40,
        backgroundColor: EHelperFunctions.isDarkMode(context) ? EColors.light : EColors.white,
        padding: const EdgeInsets.all(ESizes.sm),
        child: Image(image: AssetImage(paymentMethod.image), fit: BoxFit.cover),
      ),
      title: Text(paymentMethod.name),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
