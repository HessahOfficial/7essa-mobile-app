import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';

class CustomFullscreenImage extends StatelessWidget {
  final double screenWidth;
  final String image;
  final void Function() onTap;

  const CustomFullscreenImage({
    super.key,
    required this.screenWidth,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.zero,
        width: screenWidth * 0.7,
        height: 80,
        decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(image)),
          borderRadius: BorderRadius.circular(15),
          color: AppColors.gray,
        ),
      ),
    );
  }
}
