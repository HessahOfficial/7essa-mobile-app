import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hessa/constants/notification_data.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/notification/presentation/views/widgets/notification_item.dart';
import 'package:hessa/generated/l10n.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          splashColor: AppColors.gray.withOpacity(0.01),
          borderRadius: BorderRadius.circular(100),
          onTap: () => context.pop(),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          S.of(context).notifications,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          itemBuilder:
              (context, index) =>
                  NotificationItem(notification: notifications[index]),
          itemCount: notifications.length,
        ),
      ),
    );
  }
}
