import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hessa/screens/contact_us_screen.dart';
import 'package:hessa/screens/login-screen.dart';
import 'package:hessa/screens/notifications_screen.dart';
import 'package:hessa/screens/privacy_policy_screen.dart';
import 'package:hessa/screens/profile_screen.dart';
import 'package:hessa/widgets/setting_item.dart';

import '../constants/app_colors.dart';


class SettingsScreen extends StatefulWidget {

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white1,
      appBar: AppBar(
        backgroundColor: AppColors.white1,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Settings", style: TextStyle(
            fontWeight: FontWeight.bold
        ),),
      ),
      body:
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.06,
          vertical: screenHeight * 0.03
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SettingItem(
                  title: "Profile Settings",
                  backgroundColor: AppColors.orange,
                  icon: Icons.person,
                  onTap: () {
                    Get.to(ProfileScreen());
                  },
                ),
                SettingItem(
                  title: "Privacy Policy",
                  backgroundColor: AppColors.lightOrange,
                  iconWidget: FaIcon(FontAwesomeIcons.checkCircle, color: AppColors.orange, size: 20,),
                  onTap: () {
                    Get.to(PrivacyPolicyScreen());
                  },
                ),
                SettingItem(
                  title: "Contact Us",
                  backgroundColor: AppColors.purple,
                  icon: Icons.alternate_email_rounded,
                  onTap: () {
                    Get.to(ContactUsScreen());
                  }
                ),
                SettingItem(
                  title: "Notifications",
                  backgroundColor: AppColors.skyBlue,
                  icon: Icons.notifications,
                  onTap: () {
                    Get.to(NotificationsScreen());
                  },
                ),
              ],
            ),
            SettingItem(
              title: "Log Out",
              backgroundColor: AppColors.skyBlue300,
              iconWidget: FaIcon(FontAwesomeIcons.doorOpen, size: 15, color: Colors.black,),
              onTap: () {
                Get.offAll(LoginScreen());
              },
            ),
          ],
      ),),
    );
  }
}
