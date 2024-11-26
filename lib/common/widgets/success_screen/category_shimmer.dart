import 'package:e_com_app/common/widgets/shimmers/shimmer.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class ECategoryShimmer extends StatelessWidget {
  const ECategoryShimmer({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const SizedBox(width: ESizes.spaceBtwItems),
        itemBuilder: (_, __) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EShimmerEffect(width: 55, height: 55, radius: 55),
              SizedBox(height: ESizes.spaceBtwItems /2),
              
              EShimmerEffect(width: 55, height: 8),
            ],
          );
        },
      ),
    );
  }
}
