import 'package:e_com_app/features/personalization/controllers/user_controller.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/constants/text_strings.dart';
import 'package:e_com_app/util/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(title: const Text('Re-Authenticate User')),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: controller.verifyEmail,
                    validator: EValidator.validateEmail,
                    decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: ETexts.email),
                  ),
                  const SizedBox(height: ESizes.spaceBtwInputFields),

                  Obx(
                      () => TextFormField(
                        obscureText: controller.hidePassword.value,
                        controller: controller.verifyPassword,
                        validator: (value) => EValidator.validateEmptyText('Password', value),
                        decoration: InputDecoration(
                          labelText: ETexts.password,
                          prefixIcon: const Icon(Iconsax.password_check),
                          suffixIcon: IconButton(
                              onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                              icon: const Icon(Iconsax.eye_slash),
                          ),
                        ),
                      ),
                  ),
                  const SizedBox(height: ESizes.spaceBtwSections),
                  
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () => controller.reAuthenticateEmailAndPasswordUser(), child: const Text('Verify')),
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }
}
