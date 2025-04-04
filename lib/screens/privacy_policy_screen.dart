import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {

  String text1 = "A terms and conditions agreement outlines the website administrator’s rules regarding user behavior, and provides information about the actions the website administrator can and will perform.";
  String text2 = "Your terms and conditions text is a contract between your website and its users. In the event of a legal dispute, arbitrators will look to this agreement to determine whether each party acted within their rights.";

  TextStyle titleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 25
  );

  TextStyle descriptionStyle = TextStyle(
      color: AppColors.gray,
      fontWeight: FontWeight.bold,
      fontSize: 15
  );

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white1,
        surfaceTintColor: AppColors.white1,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.accentColor,),
        ),
        title: Text("Terms of Service", style: TextStyle(
            fontWeight: FontWeight.bold
        ),),
      ),
      backgroundColor: AppColors.white1,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 20,
          left: screenWidth * 0.06,
          right: screenWidth * 0.06
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Terms", style: titleStyle,),
                SizedBox(height: 20),
                Text(text1, style: descriptionStyle,),
                SizedBox(height: 20),
                Text(text2, style: descriptionStyle,),
              ],
            ),
            SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("User License", style: titleStyle,),
                SizedBox(height: 20),
                Text(text1, style: descriptionStyle,),
                SizedBox(height: 20),
                Text(text2, style: descriptionStyle,),
              ],
            ),
            SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Our Privacy Policy", style: titleStyle,),
                SizedBox(height: 20),
                Text(text1, style: descriptionStyle,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
