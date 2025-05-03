import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';

class CustomPropertyCard extends StatelessWidget {
  const CustomPropertyCard({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 2),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 10,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.gray.withOpacity(0.4),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Apartment",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.bookmark_border_outlined,
                      color:
                          isDark
                              ? Colors.white
                              : Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
                Text(
                  "Location",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    overflow: TextOverflow.ellipsis,
                    color: AppColors.gray,
                  ),
                ),
                Text(
                  "2550LE / Share",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [Icon(Icons.square_foot), Text("2200 sqft")]),
                    Row(
                      spacing: 1,
                      children: [
                        Icon(Icons.bed, color: AppColors.gray),
                        Text("5", style: TextStyle(color: AppColors.gray)),
                        SizedBox(width: 5),
                        Icon(Icons.bathtub, color: AppColors.gray),
                        Text("2", style: TextStyle(color: AppColors.gray)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
