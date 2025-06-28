import 'package:flutter/material.dart';

class CustomBadge extends StatelessWidget {
  final String? text;
  final Color? color;
  final List<Color>? gradiantList;

  const CustomBadge({super.key, this.text, this.color, this.gradiantList});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Colors.black,
        borderRadius: BorderRadius.circular(10),
        gradient:
            gradiantList != null ? LinearGradient(colors: gradiantList!) : null,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
      child: Text(
        text ?? "Badge",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
