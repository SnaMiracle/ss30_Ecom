import 'package:e_com_app/common/widgets/loaders/loaders.dart';
import 'package:e_com_app/common/widgets/loaders/network_manager.dart';
import 'package:e_com_app/data/repositories/authentication/authenication_repository.dart';
import 'package:e_com_app/data/repositories/user/user_model.dart';
import 'package:e_com_app/data/repositories/user/user_repository.dart';
import 'package:e_com_app/features/authentication/screens/login/login.dart';
import 'package:e_com_app/features/personalization/screens/profile/widgets/re_authenticate_user_login_form.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/popups/EFullScreenLoader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();


  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  ///--fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      ///--refresh user record
      await fetchUserRecord();

      if(user.value.id.isEmpty) {
        if(userCredentials != null) {
          ///--convert name to first and last name
          final nameParts = UserModel.nameParts(
              userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(
              userCredentials.user!.displayName ?? '');

          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            username: username,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

        await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      ELoaders.warningSnackBar(
          title: 'Data not saved',
        message: 'Something went wrong while saving your information. You can re-save your data in your Profile.',
      );
    }
  }
  
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(ESizes.md),
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will removed permanently.',
      confirm: ElevatedButton(
          onPressed: () async => deleteUserAccount(),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
          child: const Padding(padding: EdgeInsets.symmetric(horizontal: ESizes.lg), child: Text('Delete')),
      ),
      cancel: OutlinedButton(
        child: const Text('Cancel'),
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ),
    );
  }

  void deleteUserAccount() async {
    try {
      EFullScreenLoader.openLoadingDialog('Processing', EImages.docer);

      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser.providerData.map((e) => e.providerId).first;
      if(provider.isNotEmpty) {
        if(provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          EFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          EFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      // EFullScreenLoader.stopLoading();
      // ELoaders.warningSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }


  //re-authenticate before delete
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      EFullScreenLoader.openLoadingDialog('Processing', EImages.docer);

      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        EFullScreenLoader.stopLoading();
        return;
      }

      if(!reAuthFormKey.currentState!.validate()) {
        EFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.reAuthenticateWithEmailAndPassword(verifyPassword.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      EFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.warningSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
      if(image != null) {
        final imageUrl = await userRepository.uploadImage('Users/Images/Profile/', image);
        ///--update image record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        ELoaders.successSnackBar(title: 'Congratulations.', message: 'Your Profile Image has been updated!');
      }
    } catch (e) {
      ELoaders.errorSnackBar(title: 'Oh Snap', message: 'Something went wrong: $e');
    }
  }
}