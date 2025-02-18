import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hessa/constants/app_colors.dart';
import 'package:get/get.dart';
import 'package:hessa/screens/email_screen.dart';

import '../widgets/custom_text_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.1,
              vertical: screenHeight * 0.1
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SvgPicture.asset("assets/images/invest.svg"),

                Padding(padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.1
                ),
                    child:Center(
                      child: Text("Invest in your favourite properties", style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    )),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customTextButton(text: 'Skip', color: AppColors.gray, onTap: () => Get.offAll(EmailScreen())),
                      customTextButton(text: 'Next', color: AppColors.primary, onTap: () => Get.offAll(EmailScreen())),
                    ],
                  ),)
              ],
            ),
          )
      ),
    );
  }
}


