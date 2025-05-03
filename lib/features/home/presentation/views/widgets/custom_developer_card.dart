import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';

class CustomDeveloperCard extends StatelessWidget {
  const CustomDeveloperCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        spacing: 10,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.gray.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
            ),
            width: 80,
            height: 80,
          ),
          Expanded(
            child: Text(
              "Developer",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.gray),
        ],
      ),
    );
  }
}
