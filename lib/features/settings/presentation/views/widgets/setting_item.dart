import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Widget? iconWidget;
  final Color? iconColor;
  final Color backgroundColor;
  final void Function()? onTap;

  const SettingItem({
    super.key,
    required this.title,
    required this.backgroundColor,
    this.icon,
    this.iconColor,
    this.iconWidget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      splashColor: AppColors.gray.withOpacity(0.1),
      onTap: onTap ?? () {},
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: backgroundColor,
              child: iconWidget ?? Icon(icon, color: iconColor ?? Colors.black),
            ),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, color: AppColors.darkGray),
          ],
        ),
      ),
    );
  }
}
