import 'package:flutter/material.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';

class CustomBadge extends StatelessWidget {
  final String? text;
  final double? width;
  final double? height;
  final double? borderRadius;

  const CustomBadge({
    super.key,
    this.text,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return Container(
      width: width ?? 60,
      height: height ?? 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 25),
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(1, 1),
            blurRadius: 7,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Text(
          text ?? "Data",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
