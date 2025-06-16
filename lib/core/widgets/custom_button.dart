import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final FontWeight? fontWeight;

  const CustomButton({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    void Function()? this.onPressed,
    Color? this.backgroundColor,
    Color? this.textColor,
    double? this.borderRadius,
    FontWeight? this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () {},
      borderRadius: BorderRadius.circular(borderRadius ?? 14),
      splashColor: AppColors.gray,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(borderRadius ?? 14),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontWeight: fontWeight ?? FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
