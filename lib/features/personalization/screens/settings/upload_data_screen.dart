import 'package:e_com_app/common/widgets/appbar/appbar.dart';
import 'package:e_com_app/common/widgets/texts/section_heading.dart';
import 'package:e_com_app/util/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../util/constants/sizes.dart';
import 'widgets/upload_data.dart';

class EUploadDataScreen extends StatelessWidget {
  const EUploadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EAppBar(
        showBackArrow: true,
        title: Text('Upload Data', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: ListView(
        padding: const EdgeInsets.all(ESizes.defaultSpace),
        children: [
          const ESectionHeading(title: 'Main Record', showActionButton: false),
          const SizedBox(height: ESizes.spaceBtwInputFields),
          
          EUploadList(title: 'Upload categories', icon: Iconsax.category, onTap: (){}),
          const SizedBox(height: ESizes.spaceBtwInputFields),

          EUploadList(title: 'Upload Brands', icon: Iconsax.shop, onTap: (){}),
          const SizedBox(height: ESizes.spaceBtwInputFields),

          EUploadList(title: 'Upload Products', icon: Iconsax.shopping_cart, onTap: (){}),
          const SizedBox(height: ESizes.spaceBtwInputFields),

          EUploadList(title: 'Upload Banner', icon: Iconsax.image, onTap: (){}),
          const SizedBox(height: ESizes.spaceBtwSections),

          const ESectionHeading(title: 'Relationships', showActionButton: false),
        ],
      ),
    );
  }
}


