import 'package:flutter/material.dart';

import 'package:hessa/core/themes/colors/app_colors.dart';

class CustomIntentIcon extends StatelessWidget {
  final void Function()? onTap;
  final Color? iconColor;
  final String title;
  final TextStyle titleStyle;
  final double iconSize;
  final IconData icon;

  const CustomIntentIcon({
    super.key,
    required this.icon,
    required this.title,
    required this.iconSize,
    required this.titleStyle,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      splashColor: Theme.of(context).colorScheme.secondary,
      onTap: onTap ?? () {},
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor ?? AppColors.accentColor,
              size: iconSize,
            ),
            Text(title, style: titleStyle),
          ],
        ),
      ),
    );
  }
}
