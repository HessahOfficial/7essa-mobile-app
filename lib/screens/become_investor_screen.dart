import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../utils/validator.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class BecomeInvestorScreen extends StatefulWidget {
  const BecomeInvestorScreen({super.key});

  @override
  State<BecomeInvestorScreen> createState() => _BecomeInvestorScreenState();
}

class _BecomeInvestorScreenState extends State<BecomeInvestorScreen> {

  TextEditingController nameController = TextEditingController();
  String name = "";
  String errorName = "";

  TextEditingController nationalIdController = TextEditingController();
  String nationalId = "";
  String errorNationalId = "";

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
        title: Text("Become Investor", style: TextStyle(
            fontWeight: FontWeight.bold
        ),),
      ),
      backgroundColor: AppColors.white1,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 30,
          left: screenWidth * 0.06,
          right: screenWidth * 0.06
        ),
        child: Column(
          spacing: 25,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: nameController,
                  inputColor: AppColors.white2,
                  label: "Full Name",
                  screenWidth: screenWidth,
                  labelColor: Colors.black,
                  type: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      name = value;
                      errorName = Validator.validateUsername(username: name);
                    });
                  },
                ),
                SizedBox(height: 2,),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(errorName, style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),),
                ),
                SizedBox(height: 10,),
                CustomTextField(
                  controller: nationalIdController,
                  inputColor: AppColors.white2,
                  label: "National ID",
                  screenWidth: screenWidth,
                  labelColor: Colors.black,
                  type: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      nationalId = value;
                      errorNationalId = Validator.validateNationalId(nationalId: nationalId);
                    });
                  },
                ),
                SizedBox(height: 2,),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(errorNationalId, style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),),
                ),
              ],
            ),

            CustomButton(
                width: 150,
                height: 50,
                text: "Save",
                onTap: () {}
            ),

            RichText(
              text: TextSpan(
                text: "By continuing you agreeing to ",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700
                ),
                children: [
                  TextSpan(
                    text: "terms & conditions",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.accentColor
                    )
                  )
                ]
              )
            )
          ],
        ),
      ),

    );
  }
}
