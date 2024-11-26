import 'package:e_com_app/common/widgets/shimmers/shimmer.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class EHorizontalProductShimmer extends StatelessWidget {
  const EHorizontalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: ESizes.spaceBtwSections),
      height: 120,
      child: ListView.separated(
        itemCount: itemCount,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: ESizes.spaceBtwItems),
        itemBuilder: (_, __) => const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            EShimmerEffect(width: 120, height: 120),
            SizedBox(width: ESizes.spaceBtwItems),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: ESizes.spaceBtwItems / 2),
                EShimmerEffect(width: 160, height: 15),
                SizedBox(height: ESizes.spaceBtwItems),
                EShimmerEffect(width: 110, height: 15),
                SizedBox(height: ESizes.spaceBtwItems / 2),
                EShimmerEffect(width: 80, height: 15),
                Spacer()
              ],
            )
          ],
        ),
      ),
    );
  }
}
