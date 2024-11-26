import 'package:e_com_app/common/widgets/shimmers/shimmer.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class EListTileShimmer extends StatelessWidget {
  const EListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            EShimmerEffect(width: 50, height: 50, radius: 50),
            SizedBox(width: ESizes.spaceBtwItems),
            Column(
              children: [
                EShimmerEffect(width: 100, height: 15),
                SizedBox(height: ESizes.spaceBtwItems / 2),
                EShimmerEffect(width: 80, height: 12),
              ],
            )
          ],
        ),
      ],
    );
  }
}
