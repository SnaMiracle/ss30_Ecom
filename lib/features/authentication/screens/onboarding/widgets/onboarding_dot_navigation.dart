import 'package:e_com_app/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';

import '../../../../../util/constants/colors.dart';
import '../../../../../util/constants/sizes.dart';
import '../../../../../util/device/device_utility.dart';
import '../../../../../util/helpers/helper_functions.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = EHelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: EDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: ESizes.defaultSpace,
      child: SmoothPageIndicator(
         count: 3,
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        effect: ExpandingDotsEffect(activeDotColor: dark ? EColors.light: EColors.dark, dotHeight: 6),
      ),
    );
  }
}