import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class SettingItem extends StatefulWidget {
  final String title;
  final IconData? icon;
  final Widget? iconWidget;
  final Color? iconColor;
  final Color backgroundColor;
  final void Function()? onTap;

  const SettingItem({
    super.key,
    required this.title,
    this.icon,
    this.iconColor,
    this.iconWidget,
    required this.backgroundColor,
    this.onTap,
  });

  @override
  State<SettingItem> createState() => _SettingItemState();
}

class _SettingItemState extends State<SettingItem> {

  late Color background;

  @override
  void initState() {
    background = AppColors.white1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onLongPressStart: (value) {
          setState(() {
            background = AppColors.gray;
          });
        },
        onLongPressEnd: (value) {
          setState(() {
            background = AppColors.white1;
          });
        },
        onTap: widget.onTap ?? () {},
        child: Container(
          decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(14)
          ),
          width: double.infinity,
          height: 60,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: widget.backgroundColor,
                  child: widget.iconWidget ?? Icon(widget.icon, color: widget.iconColor ?? Colors.black),
                ),
                SizedBox(width: 10),
                Text(widget.title, style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23
                ),),
                Spacer(),
                Icon(Icons.arrow_forward_ios_rounded, color: AppColors.darkGray,)
              ],
            ),),
        ),
    ),);
  }
}
