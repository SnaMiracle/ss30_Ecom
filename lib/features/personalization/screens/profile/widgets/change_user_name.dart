import 'package:e_com_app/common/widgets/appbar/appbar.dart';
import 'package:e_com_app/features/personalization/controllers/update_name_controller.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/constants/text_strings.dart';
import 'package:e_com_app/util/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeUserNameScreen extends StatelessWidget {
  const ChangeUserNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: EAppBar(
        showBackArrow: true,
        title: Text('Change Username', style: Theme
            .of(context)
            .textTheme
            .headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(ESizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ///--heading
            Text('You can you all your nickname that you like. Choose a unique nickname that will represent your profile on the platform.',
              style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: ESizes.spaceBtwSections),

            Form(
              key: controller.updateNicknameFormKey,
              child: TextFormField(
                controller: controller.username,
                validator: (value) => EValidator.validateEmptyText('Username', value),
                expands: false,
                decoration: const InputDecoration(
                    labelText: ETexts.username,
                    prefixIcon: Icon(Iconsax.user)),
              ),
            ),
            const SizedBox(height: ESizes.spaceBtwSections),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.updateUserNickname(), child: const Text('Save')),
            ),
          ],
        ),
      ),
    );
  }
}
