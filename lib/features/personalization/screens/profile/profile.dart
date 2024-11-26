import 'package:e_com_app/common/widgets/appbar/appbar.dart';
import 'package:e_com_app/common/widgets/images/e_circular_image.dart';
import 'package:e_com_app/common/widgets/texts/section_heading.dart';
import 'package:e_com_app/features/personalization/controllers/user_controller.dart';
import 'package:e_com_app/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:e_com_app/features/personalization/screens/profile/widgets/change_user_name.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const EAppBar(
        showBackArrow: true, title: Text('Profile')),
      /// -- body
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(

            ///-- profile pic
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx((){
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty ? networkImage : EImages.user;
                      return ECircularImage(image: image, width: 80, height: 80, padding: 0, isNetworkImage: networkImage.isNotEmpty);
                    }),
                    TextButton(onPressed: () => controller.uploadUserProfilePicture(), child: const Text('Change Profile Picture')),
                  ],
                ),
              ),

              ///--detail
              const SizedBox(height: ESizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: ESizes.spaceBtwItems),

              ///--profile
              const ESectionHeading(title: 'Profile Information', showActionButton: false),
              const SizedBox(height: ESizes.spaceBtwItems),

              EProfileMenu(title: 'Name', value: controller.user.value.fullName, onPressed: () => Get.to(() => const ChangeName())),
              EProfileMenu(title: 'Username', value: controller.user.value.username, onPressed: () => Get.to(() => const ChangeUserNameScreen())),

              const SizedBox(height: ESizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: ESizes.spaceBtwItems),

              ///-- personal info
              const ESectionHeading(title: 'Profile Information', showActionButton: false),
              const SizedBox(height: ESizes.spaceBtwItems),

              EProfileMenu(title: 'User ID', value: controller.user.value.id, icon: Iconsax.copy, onPressed: () {}),
              EProfileMenu(title: 'Email', value: controller.user.value.email, onPressed: () {}),
              EProfileMenu(title: 'Phone Number', value: controller.user.value.phoneNumber, onPressed: () {}),
              EProfileMenu(title: 'Gender', value: 'Male', onPressed: () {}),
              EProfileMenu(title: 'Date of Birth', value: '25 Feb 2001', onPressed: () {}),
              const Divider(),
              const SizedBox(height: ESizes.spaceBtwItems),
              
              Center(
                child: TextButton(onPressed: () => controller.deleteUserAccount(), child: const Text('Delete Account', style: TextStyle(color: Colors.red))
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


