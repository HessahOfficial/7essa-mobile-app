import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/generated/l10n.dart';

class ForgotPasswordCtaScreen extends StatelessWidget {
  const ForgotPasswordCtaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 25,
          children: [
            Icon(Icons.inbox, color: AppColors.newAddedColor, size: 120),
            Text(
              S.of(context).forgotPasswordResponse,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            CustomButton(
              onPressed: () => context.go(AppRoutes.loginView),
              width: 150,
              height: 50,
              text: S.of(context).login,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
