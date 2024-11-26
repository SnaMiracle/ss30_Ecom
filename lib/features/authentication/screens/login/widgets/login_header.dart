import 'package:e_com_app/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../../util/constants/image_strings.dart';
import '../../../../../util/constants/sizes.dart';
import '../../../../../util/constants/text_strings.dart';

class ELoginHeader extends StatelessWidget {
  const ELoginHeader({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 80,
          image: AssetImage(dark ? EImages.lightAppLogo : EImages.darkAppLogo),
        ),
        const SizedBox(height: ESizes.spaceBtwInputFields),
        Text(ETexts.loginTitle, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: ESizes.sm),
        Text(ETexts.loginSubtitle, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}