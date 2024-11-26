import 'package:e_com_app/common/widgets/images/e_circular_image.dart';
import 'package:e_com_app/features/personalization/controllers/user_controller.dart';
import 'package:e_com_app/util/constants/colors.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EUserProfileTile extends StatelessWidget {
  const EUserProfileTile({
    super.key, required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final networkImage = controller.user.value.profilePicture;
    final image = networkImage.isNotEmpty ? networkImage : EImages.user;
    return ListTile(
      leading: ECircularImage(
          image: image, width: 50, height: 50, padding: 0, isNetworkImage: networkImage.isNotEmpty),
      title: Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: EColors.white)),
      subtitle: Text(controller.user.value.email, style: Theme.of(context).textTheme.bodyMedium!.apply(color: EColors.white)),
      trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit, color: EColors.white)),
    );
  }
}