import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/utils/service_locator.dart';

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
    Future.delayed(
      Duration(seconds: 5),
      // ignore: use_build_context_synchronously
      () async {
        final currentUser = await getIt.get<HiveHelper>().getCurrentUser();
        if (currentUser != null) {
          print("currentUser: $currentUser");
          context.go(AppRoutes.mainView);
        } else {
          context.go(AppRoutes.onBoardingView);
        }
      },
    );
    super.initState();
  }
}
