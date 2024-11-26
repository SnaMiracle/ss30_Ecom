import 'package:e_com_app/common/widgets/success_screen/success_screen.dart';
import 'package:e_com_app/data/repositories/authentication/authenication_repository.dart';
import 'package:e_com_app/features/authentication/controllers/signup/verfiy_email_controller.dart';
import 'package:e_com_app/features/authentication/screens/login/login.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/constants/text_strings.dart';
import 'package:e_com_app/util/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/constants/sizes.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => AuthenticationRepository.instance.logout(), icon: const Icon(CupertinoIcons.clear))
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(ESizes.defaultSpace),
            child: Column(
              children: [
                ///--image
                Image(image: const AssetImage(EImages.deliveredEmailIllustration), width: EHelperFunctions.screenWidth() * 0.6),
                const SizedBox(height: ESizes.spaceBtwSections),

                ///--title % sub
                Text(ETexts.confirmEmail, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
                const SizedBox(height: ESizes.spaceBtwItems),
                Text(email ?? '', style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center),
                const SizedBox(height: ESizes.spaceBtwItems),
                Text(ETexts.confirmEmailSubTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
                const SizedBox(height: ESizes.spaceBtwSections),

                ///--buttons
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => controller.checkEmailVerificationStatus(),
                    child: const Text(ETexts.eContinue),
                    ),
                ),
                const SizedBox(height: ESizes.spaceBtwItems),
                SizedBox(width: double.infinity, child: TextButton(onPressed: () => controller.sendEmailVerification(), child: const Text(ETexts.resentEmail))),
            ],
          ),
        ),
      ),
    );
  }
}
