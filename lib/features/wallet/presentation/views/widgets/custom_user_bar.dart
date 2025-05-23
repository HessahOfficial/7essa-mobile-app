import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';

class CustomUserBar extends StatelessWidget {
  const CustomUserBar({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel currentUser = getIt.get<HiveHelper>().currentUser!;

    return Row(
      spacing: 10,
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 25,
          child: Image.network(currentUser.avatar!, fit: BoxFit.cover),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentUser.username!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              currentUser.email!,
              style: TextStyle(
                color: AppColors.gray,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
