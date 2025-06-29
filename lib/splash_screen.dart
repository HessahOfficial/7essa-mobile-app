import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/verify_token.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final logo =
        getIt.get<HiveHelper>().isDark ?? false ? "Logo-white.svg" : "Logo.svg";

    return Scaffold(
      body: Center(child: SvgPicture.asset('assets/images/$logo')),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5), () {
      final currentUser = getIt.get<HiveHelper>().currentUser;
      final tokens = getIt.get<HiveHelper>().token;
      if (currentUser != null) {
        bool isExpired = verifyToken(accessToken: tokens!.accessToken!);
        if (isExpired) {
          context.go(AppRoutes.loginView);
        } else {
          context.go(AppRoutes.mainView);
        }
      } else {
        bool isFirstLaunch = getIt.get<HiveHelper>().isFirstLaunch ?? false;
        if (!isFirstLaunch) {
          context.go(AppRoutes.loginView);
        } else {
          context.go(AppRoutes.onBoardingView);
        }
      }
    });
  }
}
