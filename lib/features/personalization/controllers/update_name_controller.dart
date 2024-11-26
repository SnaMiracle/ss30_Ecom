
import 'package:e_com_app/common/widgets/loaders/loaders.dart';
import 'package:e_com_app/common/widgets/loaders/network_manager.dart';
import 'package:e_com_app/data/repositories/user/user_repository.dart';
import 'package:e_com_app/features/personalization/controllers/user_controller.dart';
import 'package:e_com_app/features/personalization/screens/profile/profile.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/popups/EFullScreenLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> updateNicknameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }
  
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
    username.text = userController.user.value.username;
  }
  
  Future<void> updateUserName() async {
    try {
      EFullScreenLoader.openLoadingDialog('We are updating your information...', EImages.docer);

      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        EFullScreenLoader.stopLoading();
        return;
      }

      if(!updateUserNameFormKey.currentState!.validate()) {
        EFullScreenLoader.stopLoading();
        return;
      }

      Map<String, dynamic> name = {'FirstName' : firstName.text.trim(), 'LastName': lastName.text.trim()};
      await userRepository.updateSingleField(name);
      
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();
      
      EFullScreenLoader.stopLoading();
      
      ELoaders.successSnackBar(title: 'Congratulations', message: 'Your Name has been updated.');
      
      Get.off(() => const ProfileScreen());
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<void> updateUserNickname() async {
    try {
      EFullScreenLoader.openLoadingDialog('We are updating your nickname...', EImages.docer);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        EFullScreenLoader.stopLoading();
        return;
      }

      if (!updateNicknameFormKey.currentState!.validate()) {
        EFullScreenLoader.stopLoading();
        return;
      }

      final newNickname = username.text.trim();
      Map<String, dynamic> nickname = {'Username': newNickname};
      await userRepository.updateSingleField(nickname);

      userController.user.value.username = newNickname;

      EFullScreenLoader.stopLoading();

      ELoaders.successSnackBar(title: 'Great!', message: 'Your nickname has been updated.');

      Get.off(() => const ProfileScreen());
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}