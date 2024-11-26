import 'package:e_com_app/common/widgets/texts/section_heading.dart';
import 'package:e_com_app/features/shop/models/payment_method_model.dart';
import 'package:e_com_app/features/shop/screens/checkout/widgets/payment_tile.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(name: 'ABA', image: EImages.aba);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {

    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(ESizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ESectionHeading(title: 'Select Payment Method', showActionButton: false),
                const SizedBox(height: ESizes.spaceBtwSections),
                EPaymentTile(paymentMethod: PaymentMethodModel(name: 'ABA', image: EImages.aba)),
                const SizedBox(height: ESizes.spaceBtwItems / 2),
                EPaymentTile(paymentMethod: PaymentMethodModel(name: 'Acelda', image: EImages.acleda)),
                const SizedBox(height: ESizes.spaceBtwItems / 2),
                EPaymentTile(paymentMethod: PaymentMethodModel(name: 'Apple Pay', image: EImages.applePay)),
                const SizedBox(height: ESizes.spaceBtwItems / 2),
                EPaymentTile(paymentMethod: PaymentMethodModel(name: 'Google Pay', image: EImages.googlePay)),
                const SizedBox(height: ESizes.spaceBtwItems / 2),
                EPaymentTile(paymentMethod: PaymentMethodModel(name: 'Credit Card', image: EImages.creditCard)),
                const SizedBox(height: ESizes.spaceBtwItems / 2),
                EPaymentTile(paymentMethod: PaymentMethodModel(name: 'Master Card', image: EImages.masterCard)),
                const SizedBox(height: ESizes.spaceBtwItems / 2),
                EPaymentTile(paymentMethod: PaymentMethodModel(name: 'Visa', image: EImages.visa)),
                const SizedBox(height: ESizes.spaceBtwItems / 2),
                EPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paypal', image: EImages.paypal)),
                const SizedBox(height: ESizes.spaceBtwItems / 2),
                const SizedBox(height: ESizes.spaceBtwSections),
              ],
            ),
          ),
        ),
    );
  }
}