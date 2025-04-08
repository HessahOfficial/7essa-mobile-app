import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomIntentIcon extends StatefulWidget {
  final void Function()? onTap;
  final Color? iconColor;
  final Color? splashColor;
  final String title;
  final TextStyle titleStyle;
  final double iconSize;
  final IconData icon;

  const CustomIntentIcon({
    super.key,
    required this.icon,
    required this.title,
    required this.iconSize,
    required this.titleStyle,
    this.iconColor,
    this.splashColor,
    this.onTap,
  });

  @override
  State<CustomIntentIcon> createState() => _CustomIntentIconState();
}

class _CustomIntentIconState extends State<CustomIntentIcon> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      splashColor: widget.splashColor ?? AppColors.lightPurple,
      highlightColor: widget.splashColor ?? AppColors.lightPurple,
      hoverDuration: Duration(milliseconds: 200),
      onTap: widget.onTap ?? () {},
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 15
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
                widget.icon,
                color: widget.iconColor ?? AppColors.accentColor,
                size: widget.iconSize
            ),
            SizedBox(height: 5,),
            Text(widget.title, style: widget.titleStyle,)
          ],
        ),
      ),
    );
  }
}
