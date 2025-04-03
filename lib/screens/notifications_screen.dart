import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hessa/constants/notification_data.dart';
import 'package:hessa/widgets/notification_item.dart';

import '../constants/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  List notifications = data;

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white1,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.accentColor,),
        ),
        title: Text("Notifications", style: TextStyle(
            fontWeight: FontWeight.bold
        ),),
      ),
      backgroundColor: AppColors.white1,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          children: [
            Expanded(child: ListView.builder(
              itemBuilder: (context, index) {
                return NotificationItem(item: notifications[index]);
              },
              itemCount: notifications.length,
            ))
          ] ,
        ),
      ),
    );
  }
}
