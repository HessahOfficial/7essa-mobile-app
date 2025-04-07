import 'package:flutter/cupertino.dart';
import 'package:hessa/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final void Function()? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final FontWeight? fontWeight;

  const CustomButton({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    void Function()? this.onTap,
    Color? this.backgroundColor,
    Color? this.textColor,
    double? this.borderRadius,
    FontWeight? this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
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
}