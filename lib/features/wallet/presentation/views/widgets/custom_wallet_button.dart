import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hive/hive.dart';

class CustomWalletButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final double? spacing;
  final void Function()? onTap;

  const CustomWalletButton({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      splashColor: AppColors.gray.withOpacity(0.4),
      onTap: onTap ?? () {},
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.gray.withOpacity(0.2),
          borderRadius: BorderRadius.circular(14),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          spacing: spacing ?? 5,
          children: [
            Icon(icon, color: Colors.white),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
