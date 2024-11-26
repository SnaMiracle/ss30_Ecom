import 'package:e_com_app/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:e_com_app/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:e_com_app/features/authentication/screens/onboarding/widgets/onboarding_next.dart';
import 'package:e_com_app/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:e_com_app/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/constants/text_strings.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: EImages.onBoardingImage1,
                title: ETexts.onBorderTitle1,
                subTitle: ETexts.onBorderSubTitle1,
              ),
              OnBoardingPage(
                image: EImages.onBoardingImage2,
                title: ETexts.onBorderTitle2,
                subTitle: ETexts.onBorderSubTitle2,
              ),
              OnBoardingPage(
                image: EImages.onBoardingImage3,
                title: ETexts.onBorderTitle3,
                subTitle: ETexts.onBorderSubTitle3,
              ),
            ],
          ),
          const OnBoardingSkip(),
          const OnBoardingDotNavigation(),
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}
