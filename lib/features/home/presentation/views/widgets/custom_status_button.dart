import 'package:flutter/material.dart';

class CustomStatusButton extends StatelessWidget {
  final String text;
  final Color color;
  final void Function()? onTap;
  final int index;
  final bool isSelected;

  const CustomStatusButton({
    super.key,
    required this.text,
    required this.color,
    this.onTap,
    required this.index,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(10),
      splashColor: color.withOpacity(0.5),
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.5) : null,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: color),
        ),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
        ),
      ),
    );
  }
}
