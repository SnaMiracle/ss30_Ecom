import 'package:e_com_app/common/widgets/appbar/appbar.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MemberScreen extends StatelessWidget {
  const MemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EAppBar(title: Text('Team Members', style: Theme.of(context).textTheme.headlineSmall), showBackArrow: true),
      body: ListView(
        children: [
          const SizedBox(height: ESizes.defaultSpace),
          ///--kok heng
          ListTile(
            leading: ClipOval(
              child: Image.asset(EImages.heng, width: 50.0, height: 50.0, fit: BoxFit.cover,),
            ),
            title: Text('Yos KokHeng', style: Theme.of(context).textTheme.titleMedium), trailing: IconButton(onPressed: () {}, icon: const Icon(Iconsax.heart5, color: Colors.red)),
          ),
          const SizedBox(height: ESizes.spaceBtwItems),

          ///--visuth
          ListTile(
            leading: ClipOval(
              child: Image.asset(EImages.visuth, width: 50.0, height: 50.0, fit: BoxFit.cover,),
            ),
            title: Text('Seng Visuth', style: Theme.of(context).textTheme.titleMedium), trailing: IconButton(onPressed: () {}, icon: const Icon(Iconsax.heart5, color: Colors.red)),
          ),
          const SizedBox(height: ESizes.spaceBtwItems),

          ///--srim
          ListTile(
            leading: ClipOval(
              child: Image.asset(EImages.srim, width: 50.0, height: 50.0, fit: BoxFit.cover,),
            ),
            title: Text('Sreang Srim', style: Theme.of(context).textTheme.titleMedium), trailing: IconButton(onPressed: () {}, icon: const Icon(Iconsax.heart5, color: Colors.red)),
          ),
          const SizedBox(height: ESizes.spaceBtwItems),

          ///--mony
          ListTile(
            leading: ClipOval(
              child: Image.asset(EImages.mony, width: 50.0, height: 50.0, fit: BoxFit.cover,),
            ),
            title: Text('Vet Somony', style: Theme.of(context).textTheme.titleMedium), trailing: IconButton(onPressed: () {}, icon: const Icon(Iconsax.heart5, color: Colors.red)),
          ),
          const SizedBox(height: ESizes.spaceBtwItems),

          ///--nha
          ListTile(
            leading: ClipOval(
              child: Image.asset(EImages.panha, width: 50.0, height: 50.0, fit: BoxFit.cover,),
            ),
            title: Text('Oun Panha', style: Theme.of(context).textTheme.titleMedium), trailing: IconButton(onPressed: () {}, icon: const Icon(Iconsax.heart5, color: Colors.red)),
          ),
          const SizedBox(height: ESizes.spaceBtwItems),

          ///--vy
          ListTile(
            leading: ClipOval(
              child: Image.asset(EImages.ravy, width: 50.0, height: 50.0, fit: BoxFit.cover,),
            ),
            title: Text('Dy Ravy', style: Theme.of(context).textTheme.titleMedium), trailing: IconButton(onPressed: () {}, icon: const Icon(Iconsax.heart5, color: Colors.red)),
          ),
          const SizedBox(height: ESizes.spaceBtwItems),

          ///--ra
          ListTile(
            leading: ClipOval(
              child: Image.asset(EImages.chanra, width: 50.0, height: 50.0, fit: BoxFit.cover,),
            ),
            title: Text('Lim Channara', style: Theme.of(context).textTheme.titleMedium), trailing: IconButton(onPressed: () {}, icon: const Icon(Iconsax.heart5, color: Colors.red)),
          ),
          const SizedBox(height: ESizes.spaceBtwItems),

          ///--sna
          ListTile(
            leading: ClipOval(
              child: Image.asset(EImages.veasna, width: 50.0, height: 50.0, fit: BoxFit.cover,),
            ),
            title: Text('Phin Chanveasna', style: Theme.of(context).textTheme.titleMedium), trailing: IconButton(onPressed: () {}, icon: const Icon(Iconsax.heart5, color: Colors.red)),
          ),
          const SizedBox(height: ESizes.spaceBtwItems),
        ],

      ),
    );
  }
}
