import 'package:e_com_app/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_com_app/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:e_com_app/util/constants/colors.dart';
import 'package:flutter/material.dart';

class EPrimaryHeaderContainer extends StatelessWidget {
  const EPrimaryHeaderContainer({
    super.key, required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ECurvedEdgesWidget(
      child: Container(
        color: EColors.primary,

        child: Stack(
          children: [

            Positioned(top: -150, right: -250, child: ECircularContainer(backgroundColor: EColors.textWhite.withOpacity(0.1))),
            Positioned(top: 100, right: -300, child: ECircularContainer(backgroundColor: EColors.textWhite.withOpacity(0.1))),
            child,
          ],
        ),
      )
    );
  }
}