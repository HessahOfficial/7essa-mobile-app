import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../utils/validator.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  TextEditingController emailAddressController = TextEditingController();
  String emailAddress = "";
  String errorEmailAddress = "";

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.accentColor,
        backgroundColor: AppColors.accentColor,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,),
        ),
      ),
      backgroundColor: AppColors.accentColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: screenHeight * 0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.white1,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)
                  )
              ),
              width: screenWidth,
              height: screenHeight,
              child: Padding(
                padding: EdgeInsets.only(
                    top: 20,
                    right: screenWidth * 0.06,
                    left: screenWidth * 0.06
                ),
                child: Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text("Forget Password", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25
                                ),),
                                Text("Please enter your email", style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18
                                ))
                              ],
                            ),
                          ),
                          SizedBox(height: 50,),
                          CustomTextField(
                            controller: emailAddressController,
                            icon: Icons.email_rounded,
                            iconColor: AppColors.green800,
                            inputColor: AppColors.white2,
                            iconBackgroundColor: AppColors.green100,
                            placeholder: "Email Address",
                            screenWidth: screenWidth,
                            type: TextInputType.emailAddress,
                            onChanged: (value) {
                              setState(() {
                                emailAddress = value;
                                errorEmailAddress = Validator.validateEmailAddress(email: emailAddress);
                              });
                            },
                          ),
                          SizedBox(height: 2,),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(errorEmailAddress, style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),),
                          ),
                          SizedBox(height: 10,),
                          CustomButton(
                              width: double.infinity,
                              height: 50,
                              text: "Send",
                              onTap: () {}
                          )
                        ],
                    ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
