import 'package:flutter/material.dart';
import 'package:hessa/constants/app_colors.dart';

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
    return GestureDetector(
      onTap: onTap?? () {},
      child: CircleAvatar(
        backgroundColor: backgroundColor?? AppColors.white2,
        radius: radius?? 30,
        child: child,
      ),
    );
  }
}