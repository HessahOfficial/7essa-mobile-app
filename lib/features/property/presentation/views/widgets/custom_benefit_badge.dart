import 'package:flutter/material.dart';

class CustomBenefitBadge extends StatelessWidget {
  final String text;

  const CustomBenefitBadge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
