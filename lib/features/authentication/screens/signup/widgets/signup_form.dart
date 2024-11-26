import 'package:e_com_app/features/authentication/controllers/signup/signup_controller.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/constants/text_strings.dart';
import 'package:e_com_app/util/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'terms_and_conditions_checkbox.dart';

class ESignupForm extends StatelessWidget {
  const ESignupForm({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Form(
      key: controller.signupFormKey,
      child: Column(
      children: [
        ///--firstname lastname
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.firstName,
                validator: (value) => EValidator.validateEmptyText('First name', value),
                expands: false,
                decoration: const InputDecoration(labelText: ETexts.firstName, prefixIcon: Icon(Iconsax.user)),
              ),
            ),
            const SizedBox(width: ESizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                controller: controller.lastName,
                validator: (value) => EValidator.validateEmptyText('Last name', value),
                expands: false,
                decoration: const InputDecoration(labelText: ETexts.lastName, prefixIcon: Icon(Iconsax.user)),
              ),
            ),
          ],
        ),
        const SizedBox(height: ESizes.spaceBtwInputFields),

        ///--username
        TextFormField(
          validator: (value) => EValidator.validateEmptyText('Username', value),
          controller: controller.userName,
          expands: false,
          decoration: const InputDecoration(labelText: ETexts.username, prefixIcon: Icon(Iconsax.user_edit)),
        ),
        const SizedBox(height: ESizes.spaceBtwInputFields),

        ///--email
        TextFormField(
          validator: (value) => EValidator.validateEmail(value),
          controller: controller.email,
          decoration: const InputDecoration(labelText: ETexts.email, prefixIcon: Icon(Iconsax.direct)),
        ),
        const SizedBox(height: ESizes.spaceBtwInputFields),

        ///--phone number
        TextFormField(
          validator: (value) => EValidator.validatePhoneNumber(value),
          controller: controller.phoneNumber,
          decoration: const InputDecoration(labelText: ETexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
        ),
        const SizedBox(height: ESizes.spaceBtwInputFields),

        
        ///--password
        Obx(
          () => TextFormField(
            validator: (value) => EValidator.validatePassword(value),
            controller: controller.password,
            obscureText: controller.hidePassword.value,
            decoration: InputDecoration(
              labelText: ETexts.password,
              prefixIcon: const Icon(Iconsax.password_check),
              suffixIcon: IconButton(
                onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                  icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
              ),
            ),
          ),
        ),
        const SizedBox(height: ESizes.spaceBtwSections),


        const ETermsAndConditionCheckbox(),
        const SizedBox(height: ESizes.spaceBtwSections),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(ETexts.createAccount),
          ),
        ),
      ],
    ),
    );
  }
}


