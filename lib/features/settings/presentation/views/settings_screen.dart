import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/features/settings/presentation/views/widgets/locale_switch.dart';
import 'package:hessa/features/settings/presentation/views/widgets/setting_item.dart';
import 'package:hessa/features/settings/presentation/views/widgets/theme_switch.dart';
import 'package:hessa/generated/l10n.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          S.of(context).settings,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SettingItem(
                  title: S.of(context).profileSettings,
                  backgroundColor: AppColors.orange,
                  icon: Icons.person,
                  onTap: () {},
                ),
                SettingItem(
                  title: S.of(context).privacyPolicy,
                  backgroundColor: AppColors.orange100,
                  iconWidget: FaIcon(
                    FontAwesomeIcons.checkCircle,
                    color: AppColors.orange,
                    size: 20,
                  ),
                  onTap: () {},
                ),
                SettingItem(
                  title: S.of(context).contactUs,
                  backgroundColor: AppColors.purple,
                  icon: Icons.alternate_email_rounded,
                  onTap: () {},
                ),
                SettingItem(
                  title: S.of(context).notifications,
                  backgroundColor: AppColors.skyBlue,
                  icon: Icons.notifications,
                  onTap: () {},
                ),
                SettingItem(
                  title: S.of(context).logout,
                  backgroundColor: AppColors.skyBlue300,
                  iconWidget: FaIcon(
                    FontAwesomeIcons.doorOpen,
                    size: 15,
                    color: Colors.black,
                  ),
                  onTap: () {},
                ),
                ThemeSwitch(title: S.of(context).darkmode),
                LocaleSwitch(title: S.of(context).locale),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
