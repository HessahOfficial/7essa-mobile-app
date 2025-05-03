import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';

class CustomCircularButton extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final double? radius;
  final void Function()? onTap;

  const CustomCircularButton({
    super.key,
    required this.child,
    Color? this.backgroundColor,
    double? this.radius,
    void Function()? this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(radius ?? 30),
      child: InkWell(
        borderRadius: BorderRadius.circular(radius ?? 30),
        onTap: onTap ?? () {},
        child: CircleAvatar(
          backgroundColor: backgroundColor ?? AppColors.backgtoundLight,
          radius: radius ?? 30,
          child: child,
        ),
      ),
    );
  }
}
