import 'package:e_com_app/common/widgets/layouts/grid_layout.dart';
import 'package:e_com_app/common/widgets/shimmers/shimmer.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class EVerticalProductShimmer extends StatelessWidget {
  const EVerticalProductShimmer({super.key, this.itemCount =4,});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return EGridLayout(
        itemCount: itemCount,
        itemBuilder: (_, __) => const SizedBox(
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EShimmerEffect(width: 180, height: 180),
              SizedBox(height: ESizes.spaceBtwItems),
              
              EShimmerEffect(width: 160, height: 15),
              SizedBox(height: ESizes.spaceBtwItems / 2),
              EShimmerEffect(width: 110, height: 15),
            ],
          ),
        ),
    );
  }
}
