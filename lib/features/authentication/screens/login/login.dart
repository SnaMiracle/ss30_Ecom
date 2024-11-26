import 'package:e_com_app/common/styles/spacing_styles.dart';
import 'package:e_com_app/common/widgets/login_signup/form_divider.dart';
import 'package:e_com_app/common/widgets/login_signup/social_bottons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/constants/sizes.dart';
import '../../../../util/constants/text_strings.dart';

import 'widgets/login_form.dart';
import 'widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: ESpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              const ELoginHeader(),


              const ELoginForm(),


              EFormDivider(dividerText: ETexts.orSignInWith.capitalize!),
              const SizedBox(height: ESizes.spaceBtwSections),


              const ESocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
