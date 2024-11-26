import 'package:e_com_app/common/widgets/login_signup/form_divider.dart';
import 'package:e_com_app/common/widgets/login_signup/social_bottons.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ETexts.signupTitle, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: ESizes.spaceBtwSections),

              const ESignupForm(),
              const SizedBox(height: ESizes.spaceBtwSections),

              EFormDivider(dividerText: ETexts.orSignUpWith.capitalize!),
              const SizedBox(height: ESizes.spaceBtwSections),

              const ESocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}



