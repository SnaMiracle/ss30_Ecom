

import 'dart:async';

import 'package:e_com_app/common/widgets/loaders/loaders.dart';
import 'package:e_com_app/common/widgets/success_screen/success_screen.dart';
import 'package:e_com_app/data/repositories/authentication/authenication_repository.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/constants/text_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  ///--sent email verification link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      ELoaders.successSnackBar(title: 'Email Sent', message: 'Please Check your inbox and verify your email.');
    } catch (e) {
      ELoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  ///--timer to au to redirect
  setTimerForAutoRedirect() {
    Timer.periodic(
      const Duration(seconds: 1),
          (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if(user?.emailVerified ?? false) {
          timer.cancel();
          Get.off(
                () => SuccessScreen(
                  image: EImages.successfullyRegister,
                  title: ETexts.yourAccountCreatedTitle,
                  subTitle: ETexts.yourAccountCreatedSubTitle,
                  onPressed: () => AuthenticationRepository.instance.screenRedirect(),
                ),
          );
        }
      },
    );
  }

  ///-check if email verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
              () => SuccessScreen(
                  image: EImages.successfullyRegister,
                  title: ETexts.yourAccountCreatedTitle,
                  subTitle: ETexts.yourAccountCreatedSubTitle,
                  onPressed: () => AuthenticationRepository.instance.screenRedirect(),
              ),
      );
    }
  }
}