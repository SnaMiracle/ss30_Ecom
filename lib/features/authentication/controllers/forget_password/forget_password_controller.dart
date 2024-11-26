
import 'package:e_com_app/common/widgets/loaders/loaders.dart';
import 'package:e_com_app/common/widgets/loaders/network_manager.dart';
import 'package:e_com_app/data/repositories/authentication/authenication_repository.dart';
import 'package:e_com_app/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/popups/EFullScreenLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  sendPasswordResetEmail() async {
    try {
      EFullScreenLoader.openLoadingDialog(('Processing your request...'), EImages.docer);

      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {EFullScreenLoader.stopLoading(); return;}

      if(!forgetPasswordFormKey.currentState!.validate()) {
        EFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      EFullScreenLoader.stopLoading();

      ELoaders.successSnackBar(title: 'Email Sent', message: 'Email Link Sent to Reset your Password'.tr);

      Get.to(() => ResetPasswordScreen(email: email.text.trim()));

    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      EFullScreenLoader.openLoadingDialog(('Processing your request...'), EImages.docer);

      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {EFullScreenLoader.stopLoading(); return;}


      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      EFullScreenLoader.stopLoading();

      ELoaders.successSnackBar(title: 'Email Sent', message: 'Email Link Sent to Reset your Password'.tr);


    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}