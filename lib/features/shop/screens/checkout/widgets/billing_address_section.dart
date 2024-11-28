// import 'package:e_com_app/common/widgets/texts/section_heading.dart';
// import 'package:e_com_app/features/personalization/controllers/address_controller.dart';
// import 'package:e_com_app/util/constants/sizes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class EBillingAddressSection extends StatelessWidget {
//   const EBillingAddressSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final addressController = Get.put(AddressController());
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ESectionHeading(title: 'Shipping Address', buttonTitle: 'Change', onPressed: () => addressController.selectNewAddressPopup(context)),
//         addressController.selectedAddress.value.id.isNotEmpty
//             ? Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('SnaMiracle', style: Theme.of(context).textTheme.bodyLarge),
//
//                   const SizedBox(height: ESizes.spaceBtwItems / 2),
//                   Row(
//                     children: [
//                       const Icon(Icons.phone, color: Colors.grey, size: 16),
//                       const SizedBox(width: ESizes.spaceBtwItems),
//                       Text('+855 87 55 87 90', style: Theme.of(context).textTheme.bodyMedium),
//                     ],
//                   ),
//                   const SizedBox(height: ESizes.spaceBtwItems / 2),
//                   Row(
//                     children: [
//                       const Icon(Icons.location_history, color: Colors.grey, size: 16),
//                       const SizedBox(width: ESizes.spaceBtwItems),
//                       Expanded(child: Text('Chak Angre leu, National Road 2, Phnom Penh', style: Theme.of(context).textTheme.bodyMedium, softWrap: true)),
//                     ],
//                   ),
//                 ],
//             ) : Text('Select Address', style: Theme.of(context).textTheme.bodyMedium),
//
//       ],
//     );
//   }
// }

import 'package:e_com_app/common/widgets/texts/section_heading.dart';
import 'package:e_com_app/features/personalization/controllers/address_controller.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EBillingAddressSection extends StatelessWidget {
  const EBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = Get.put(AddressController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ESectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          onPressed: () => addressController.selectNewAddressPopup(context),
        ),
        Obx(() {
          if (addressController.selectedAddress.value.id.isEmpty) {
            return Text('No address selected', style: Theme.of(context).textTheme.bodyMedium);
          }
          final address = addressController.selectedAddress.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address.name, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: ESizes.spaceBtwItems / 2),

              Row(
                children: [
                  const Icon(Icons.phone, color: Colors.grey, size: 16),
                  const SizedBox(width: ESizes.spaceBtwItems),
                  Text(address.phoneNumber, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),

              const SizedBox(height: ESizes.spaceBtwItems / 2),

              Row(
                children: [
                  const Icon(Icons.location_history, color: Colors.grey, size: 16),
                  const SizedBox(width: ESizes.spaceBtwItems),Text(
                    '${address.street}, ${address.city}, ${address.state}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          );
        }),
      ],
    );
  }
}

