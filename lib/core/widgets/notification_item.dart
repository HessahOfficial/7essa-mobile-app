import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';

import '../../constants/notification_data.dart';

class NotificationItem extends StatefulWidget {
  final NotificationModel item;

  const NotificationItem({super.key, required this.item});

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  late Color background;

  @override
  void initState() {
    background = AppColors.backgtoundLight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onLongPressStart: (value) {
          setState(() {
            background = AppColors.accentColor;
          });
        },
        onLongPressEnd: (value) {
          setState(() {
            background = AppColors.backgtoundLight;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.backgtoundLight,
            borderRadius: BorderRadius.circular(14),
          ),
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.lightPurple,
                  child: Icon(
                    Icons.notifications,
                    color: AppColors.accentColor,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.type,
                        style: TextStyle(
                          color: AppColors.gray,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.item.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.visible,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
