import 'package:e_com_app/common/widgets/appbar/appbar.dart';
import 'package:e_com_app/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:e_com_app/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:e_com_app/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:e_com_app/common/widgets/texts/section_heading.dart';
import 'package:e_com_app/features/authentication/screens/login/login.dart';
import 'package:e_com_app/features/personalization/screens/address/address.dart';
import 'package:e_com_app/features/personalization/screens/settings/memeber_screen.dart';
import 'package:e_com_app/features/personalization/screens/settings/upload_data_screen.dart';
import 'package:e_com_app/features/shop/screens/bank/bank_screen.dart';
import 'package:e_com_app/features/shop/screens/cart/cart.dart';
import 'package:e_com_app/features/shop/screens/order/order.dart';
import 'package:e_com_app/util/constants/colors.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import '../profile/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- header
            EPrimaryHeaderContainer(
              child: Column(
                children: [EAppBar(title: Text('Account', style: Theme.of(context).textTheme.headlineMedium!.apply(color: EColors.white))),

                  /// --user profile
                  EUserProfileTile(onPressed: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: ESizes.spaceBtwSections),
                ],
              ),
            ),

            /// --body
            Padding(
                padding: const EdgeInsets.all(ESizes.defaultSpace),
              child: Column(
                children: [
                  /// -- account setting
                  const ESectionHeading(title: 'Account Setting', showActionButton: false),
                  const SizedBox(height: ESizes.spaceBtwItems),

                  ESettingsMenuTile(icon: Iconsax.safe_home, title: 'My Addresses', subTitle: 'Set shopping delivery address', onTap: () => Get.to(() => const UserAddressScreen())
                  ),
                  ESettingsMenuTile(icon: Iconsax.shopping_cart, title: 'My Cart', subTitle: 'Add, remove products and move to checkout', onTap: () => Get.to(() => const CartScreen())),
                  ESettingsMenuTile(icon: Iconsax.bag_tick, title: 'My Orders', subTitle: 'In-progress and Completed Orders', onTap: () => Get.to(() => const OrderScreen())
                  ),
                  ESettingsMenuTile(icon: Iconsax.bank, title: 'Bank Account', subTitle: 'Withdraw balance to registered bank account', onTap: () => Get.to(() => const AddBankScreen()),
                  ),
                  const ESettingsMenuTile(icon: Iconsax.discount_shape, title: 'My Coupons', subTitle: 'List of all the discounted coupons'),
                  const ESettingsMenuTile(icon: Iconsax.notification, title: 'Notifications', subTitle: 'Set any kind of notification message'),
                  const ESettingsMenuTile(icon: Iconsax.security_card, title: 'Account Privacy', subTitle: 'Manage data usage and connected accounts'),

                  /// -- app setting
                  const SizedBox(height: ESizes.spaceBtwSections),
                  const ESectionHeading(title: 'App Settings', showActionButton: false),
                  const SizedBox(height: ESizes.spaceBtwItems),
                  ESettingsMenuTile(icon: Iconsax.document_upload, title: 'Load Data', subTitle: 'Upload Data to your Cloud Firebase', onTap: () => Get.to(() => const EUploadDataScreen())),
                  ESettingsMenuTile(icon: Iconsax.profile_2user, title: 'About Us', subTitle: 'Our Team Members', onTap: () => Get.to(() => const MemberScreen())),
                  ESettingsMenuTile(icon: Iconsax.location, title: 'Geolocation', subTitle: 'Set recommendation based pn location', trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  ESettingsMenuTile(icon: Iconsax.security_user, title: 'Safe Mode', subTitle: 'Search result is safe for all ages', trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  ESettingsMenuTile(icon: Iconsax.image, title: 'HD Image Quality', subTitle: 'Set image quality to be seen', trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  const SizedBox(height: ESizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: () => Get.to(() => const LoginScreen()), child: const Text('Logout')),
                  ),
                  const SizedBox(height: ESizes.spaceBtwSections * 2.5),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


