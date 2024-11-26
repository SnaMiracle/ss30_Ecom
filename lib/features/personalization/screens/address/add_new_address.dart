import 'package:e_com_app/common/widgets/appbar/appbar.dart';
import 'package:e_com_app/features/personalization/controllers/address_controller.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;

    return Scaffold(
      appBar: const EAppBar(showBackArrow: true, title: Text('Add Address')),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              mainAxisSize:  MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controller.name,
                    validator: (value) => EValidator.validateEmptyText('Name', value),
                    decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: 'Name')),
                const SizedBox(height: ESizes.spaceBtwInputFields),
                TextFormField(
                  controller: controller.phoneNumber,
                    validator: EValidator.validatePhoneNumber,
                    decoration: const InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: 'Phone Number'),
                ),
                const SizedBox(height: ESizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(child: TextFormField(
                      controller: controller.street,
                        validator: (value) => EValidator.validateEmptyText('Street', value),
                        decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building_31), labelText: 'Street'),
                      ),
                    ),
                    const SizedBox(width: ESizes.spaceBtwInputFields),
                    Expanded(
                        child: TextFormField(
                          controller: controller.postalCode,
                            validator: (value) => EValidator.validateEmptyText('Postal Code', value),
                            decoration: const InputDecoration(prefixIcon: Icon(Iconsax.code), labelText: 'Postal Code'),
                        ),
                    ),
                  ],
                ),
                const SizedBox(height: ESizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(child: TextFormField(
                      controller: controller.city,
                        validator: (value) => EValidator.validateEmptyText('City', value),
                        expands: false,
                        decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building), labelText: 'City'),
                      ),
                    ),
                    const SizedBox(width: ESizes.spaceBtwInputFields),
                    Expanded(child: TextFormField(
                      controller: controller.state,
                        validator: (value) => EValidator.validateEmptyText('State', value),
                        expands: false,
                        decoration: const InputDecoration(prefixIcon: Icon(Iconsax.activity), labelText: 'State'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: ESizes.spaceBtwInputFields),
                TextFormField(
                  controller: controller.country,
                    validator: (value) => EValidator.validateEmptyText('Country', value),
                    decoration: const InputDecoration(prefixIcon: Icon(Iconsax.global), labelText: 'Country')),
                const SizedBox(height: ESizes.defaultSpace),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => controller.addNewAddresses(), child: const Text('Save')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
