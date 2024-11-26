import 'package:e_com_app/common/widgets/loaders/loaders.dart';
import 'package:e_com_app/common/widgets/loaders/network_manager.dart';
import 'package:e_com_app/data/repositories/authentication/authenication_repository.dart';
import 'package:e_com_app/features/personalization/controllers/user_controller.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/popups/EFullScreenLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController  extends GetxController {

  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());


  // @override
  // void onInit() {
  //   email.text = localStorage.read('REMEMBER_ME_MAIL');
  //   password.text = localStorage.read('REMEMBER_ME_PASSWORD');
  //   super.onInit();
  // }

  ///--email password sign in
  Future<void> emailAndPasswordSignIn() async {
    try {
      EFullScreenLoader.openLoadingDialog('Logging you in...', EImages.docer);

      ///--check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        EFullScreenLoader.stopLoading();
        return;
      }
      
      ///--validate form
      if(!loginFormKey.currentState!.validate()) {
        EFullScreenLoader.stopLoading();
        return;
      }
      
      ///-- save data remember is selected
      if(rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }
      
      ///--login user using email
      final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      ///--remove loader
      EFullScreenLoader.stopLoading();


      ///--redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<void> googleSignIn() async {
    try {

      EFullScreenLoader.openLoadingDialog('Logging you in...', EImages.docer);

      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        EFullScreenLoader.stopLoading();
        return;
      }

      ///--google authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      await userController.saveUserRecord(userCredentials);

      EFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();

    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}