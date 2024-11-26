import 'package:e_com_app/common/styles/spacing_styles.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/constants/text_strings.dart';
import 'package:e_com_app/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';


class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subTitle, required this.onPressed});

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: ESpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            children: [

              Image(image: AssetImage(image), width: EHelperFunctions.screenWidth() * 0.6),
              const SizedBox(height: ESizes.spaceBtwSections),

              Text(title, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: ESizes.spaceBtwItems),
              Text(subTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
              const SizedBox(height: ESizes.spaceBtwSections),

              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: onPressed, child: const Text(ETexts.eContinue))
              ),
            ],
          ),
        ),
      ),
    );
  }
}
