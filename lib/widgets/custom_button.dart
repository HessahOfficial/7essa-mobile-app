import 'package:flutter/cupertino.dart';
import 'package:hessa/constants/app_colors.dart';

Widget customButton({
  required double width,
  required double height,
  required String text,
  void Function()? onTap,
  Color? backgroundColor,
  Color? textColor,
  double? borderRadius,
  FontWeight? fontWeight,
}) {
  return GestureDetector(
    onTap: onTap?? () {},
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor?? AppColors.secondary,
        borderRadius: BorderRadius.circular(borderRadius?? 14)
      ),
      child: Center(
        child: Text(text, style: TextStyle(
          color: textColor?? AppColors.white2,
          fontWeight: fontWeight?? FontWeight.w600
        ),),
      ),
    ),
  );
}