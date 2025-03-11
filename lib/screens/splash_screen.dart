import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hessa/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: SvgPicture.asset('assets/images/Logo.svg'),
          ),
        )
    );
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 5), () => {
      Get.offAll(() => OnboardingScreen())
    });
    super.initState();
  }
}

