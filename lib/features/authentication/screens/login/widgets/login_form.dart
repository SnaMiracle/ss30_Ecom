import 'package:e_com_app/features/authentication/controllers/login/login_controller.dart';
import 'package:e_com_app/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:e_com_app/features/authentication/screens/signup/signup.dart';
import 'package:e_com_app/navigation_menu.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/constants/text_strings.dart';
import 'package:e_com_app/util/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class ELoginForm extends StatelessWidget {
  const ELoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: ESizes.spaceBtwSections),
        child: Column(
          children: [

            ///--email
            TextFormField(
              controller: controller.email,
              validator: (value) => EValidator.validateEmail(value),
              decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: ETexts.email),
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
            const SizedBox(height: ESizes.spaceBtwInputFields / 2),

            ///--remember & forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(() => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value),
                    ),
                    const Text(ETexts.rememberMe),
                  ],
                ),

                TextButton(onPressed: () => Get.to(() => const ForgetPassword()), child: const Text(ETexts.forgetPassword),)
              ],
            ),
            const SizedBox(height: ESizes.spaceBtwSections),

            SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => controller.emailAndPasswordSignIn(), child: const Text(ETexts.signIn))),
            const SizedBox(height: ESizes.spaceBtwItems),

            SizedBox(
                width: double.infinity,
                child: OutlinedButton(onPressed: () => Get.to(() => const SignupScreen()), child: const Text(ETexts.createAccount))
            ),
          ],
        ),
      ),
    );
  }
}