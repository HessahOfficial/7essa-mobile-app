import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/lang.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';
import 'package:hessa/generated/l10n.dart';

class HotPropertiesTitle extends StatelessWidget {
  const HotPropertiesTitle({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;
    bool arabic = isArabic();
    UserModel currentUser = getIt.get<HiveHelper>().currentUser!;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.06,
        vertical: screenHeight * 0.03,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              text: arabic ? S.of(context).properties : S.of(context).hot,
              style: TextStyle(
                color: AppColors.hotColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
              children: [
                TextSpan(
                  text: arabic ? S.of(context).hot : S.of(context).properties,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                ),
              ],
            ),
          ),
          if (!currentUser.isInvestor!)
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(14),
              child: CustomButton(
                onPressed: () => context.push(AppRoutes.becomeInvestorView),
                width: arabic ? 100 : 160,
                height: 30,
                text: S.of(context).becomeInvestor,
                textColor: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
