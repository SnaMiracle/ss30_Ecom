import 'package:e_com_app/common/widgets/loaders/loaders.dart';
import 'package:e_com_app/common/widgets/loaders/network_manager.dart';
import 'package:e_com_app/data/repositories/authentication/authenication_repository.dart';
import 'package:e_com_app/data/repositories/user/user_model.dart';
import 'package:e_com_app/data/repositories/user/user_repository.dart';
import 'package:e_com_app/features/authentication/screens/signup/verify_email.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/popups/EFullScreenLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signup() async {
    try {
      ///-- start loading
      EFullScreenLoader.openLoadingDialog('We are processing your information...', EImages.docer);

      ///--check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        EFullScreenLoader.stopLoading();
        return;
      }

      ///--form validation
      if(!signupFormKey.currentState!.validate()) {
        EFullScreenLoader.stopLoading();
        return;
      }

      ///privacy policy check
      if(!privacyPolicy.value) {
        ELoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message: 'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use.'
        );
        return;
      }

      ///register from firebase
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      ///--save user date to firebase
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: userName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      EFullScreenLoader.stopLoading();
      
      ELoaders.successSnackBar(title: 'Congratulations', message: 'Your account has been created! Verify email to continue.');

      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ///---show error to user
      ELoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());

    }
  }
}
