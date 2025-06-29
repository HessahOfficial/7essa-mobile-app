import 'package:flutter/material.dart';

class CustomBadge extends StatelessWidget {
  final String? text;
  final Color? color;

  const CustomBadge({super.key, this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
      child: Text(
        text ?? "Badge",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
