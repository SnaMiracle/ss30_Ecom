import 'package:e_com_app/common/widgets/chips/choice_chip.dart';
import 'package:e_com_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_com_app/common/widgets/texts/product_price_text.dart';
import 'package:e_com_app/common/widgets/texts/product_title_text.dart';
import 'package:e_com_app/common/widgets/texts/section_heading.dart';
import 'package:e_com_app/features/shop/controller/product/variation_controller.dart';
import 'package:e_com_app/features/shop/models/product_model.dart';
import 'package:e_com_app/util/constants/colors.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EProductAttributes extends StatelessWidget {
  const EProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VariationController());
    final dark = EHelperFunctions.isDarkMode(context);
    
    return Obx(
      () => Column(
        children: [
      
          if (controller.selectedVariation.value.id.isNotEmpty)
          ERoundedContainer(
            padding: const EdgeInsets.all(ESizes.md),
            backgroundColor: dark ? EColors.darkerGrey : EColors.grey,
            child: Column(
              children: [
                ///-- title price stock
                Row(
                 children: [
                   const ESectionHeading(title: 'Variation', showActionButton: false),
                   const SizedBox(width: ESizes.spaceBtwItems),
      
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(
                         children: [
                           const EProductTitleText(title: 'Price : ', smallSize: true),
      
                           ///-- actual price
                           if (controller.selectedVariation.value.salePrice > 0)
                           Text('\$${controller.selectedVariation.value.price}',
                             style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),
                           ),
                           const SizedBox(width: ESizes.spaceBtwItems),
      
                           ///-- sale price
                           EProductPriceText(price: controller.getVariationPrice()),
                         ],
                       ),
      
                       ///--stock
                       Row(
                         children: [
                           const EProductTitleText(title: 'Stock : ', smallSize: true),
                           Text(controller.variationStockStatus.value, style: Theme.of(context).textTheme.titleMedium),
                         ],
                       ),
                     ],
                   ),
                 ], 
                ),
      
                ///--variation desc
                EProductTitleText(title: controller.selectedVariation.value.description ?? '', smallSize: true, maxLines: 4
                ),
              ],
            ),
          ),
          const SizedBox(height: ESizes.spaceBtwItems),
      
          ///-- attribute
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!.map((attribute) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ESectionHeading(title: attribute.name ?? '', showActionButton: false,),
                const SizedBox(height: ESizes.spaceBtwItems / 2),
                Obx(
                  () => Wrap(
                    spacing: 8,
                    children: attribute.values!.map((attributeValue) {
      
                          final isSelected = controller.selectedAttributes[attribute.name] == attributeValue;
                          final available = controller
                              .getAttributesAvailabilityInVariation(product.productVariations!, attribute.name!)
                              .contains(attributeValue);
      
                          return  EChoiceChip(text: attributeValue, selected: isSelected, onSelected: available ? (selected) {
                            if (selected && available) {
                              controller.onAttributeSelected(product, attribute.name ?? '', attributeValue);
                            }
                          } : null);
                        }).toList()),
                )
              ],
            )).toList(),
          )
        ],
      ),
    );
  }
}
