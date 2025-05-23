import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAvatar extends StatelessWidget {
  final File? image;

  const CustomAvatar({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 10),
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        // color: AppColors.accentColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child:
          image == null
              ? SvgPicture.asset("assets/images/google.svg", fit: BoxFit.cover)
              : Image.file(image!, fit: BoxFit.cover),
    );
  }
}
