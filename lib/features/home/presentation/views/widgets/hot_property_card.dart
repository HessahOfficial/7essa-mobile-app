import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/lang.dart';

class HotPropertyCard extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const HotPropertyCard({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    bool arabic = isArabic();

    return Container(
      margin: EdgeInsets.only(
        right: arabic ? 0 : screenWidth * 0.1,
        left: arabic ? screenWidth * 0.1 : 0,
      ),
      width: screenWidth * 0.67,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 15,
            spreadRadius: 2,
            offset: Offset(0, 8),
          ),
        ],
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: AppColors.gray.withOpacity(0.4),
              ),
              width: double.infinity,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.08),
                          blurRadius: 15,
                          spreadRadius: 2,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.bookmark_border_rounded,
                        size: 24,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Apartment",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 20, color: AppColors.gray),
                      Text(
                        "Location",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          overflow: TextOverflow.ellipsis,
                          color: AppColors.gray,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "2550LE / Share",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
