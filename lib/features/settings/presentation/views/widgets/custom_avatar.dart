import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel currentUser = getIt.get<HiveHelper>().currentUser!;

    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 10),
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        // color: AppColors.accentColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Image(image: NetworkImage(currentUser.avatar!), fit: BoxFit.cover),
    );
  }
}
