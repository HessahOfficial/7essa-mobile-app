import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';

class CustomLabel extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final Color? color;

  const CustomLabel({super.key, this.text, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color ?? AppColors.gray,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon, size: 15, color: Colors.white),
          Text(
            text ?? "Label",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
