import 'package:flutter/material.dart';
import 'package:hessa/constants/app_colors.dart';

Widget customCircularButton({
  required Widget child,
  Color? backgroundColor,
  double? radius,
  void Function()? onTap
}) {
  return GestureDetector(
    onTap: onTap?? () {},
    child: CircleAvatar(
      backgroundColor: backgroundColor?? AppColors.white2,
      radius: radius?? 30,
      child: child,
    ),
  );
}