import 'package:flutter/material.dart';

class CustomCategoryTab extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String text;
  final Color color;
  final void Function()? onTap;

  const CustomCategoryTab({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.text,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap ?? () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selectedIndex == index ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selectedIndex == index ? Colors.white : color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
