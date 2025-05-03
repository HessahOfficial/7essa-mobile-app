import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';

class CustomUserBar extends StatelessWidget {
  const CustomUserBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 25,
          child: SvgPicture.asset("assets/images/google.svg"),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "User Name",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              "username@gmail.com",
              style: TextStyle(
                color: AppColors.gray,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
