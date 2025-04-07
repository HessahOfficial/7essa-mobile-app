import 'package:flutter/material.dart';

Widget customTextButton({
  required String text,
  required Color color,
  void Function()? onTap
}) {
  return GestureDetector(
    onTap: onTap,
    child: Text(text, style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: 20
    ),),
  );
}