import 'package:e_com_app/util/constants/colors.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ESearchContainer extends StatelessWidget {
  const ESearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    required this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: showBackground ? dark ? EColors.dark : EColors.light : Colors.transparent,
            borderRadius: BorderRadius.circular(ESizes.cardRadiusLg),
            border: showBorder ? Border.all(color: EColors.grey) : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.grey),
              const SizedBox(width: 8.0),
              Text(
                text,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
