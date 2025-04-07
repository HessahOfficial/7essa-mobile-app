import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hessa/screens/login-screen.dart';

import '../constants/app_colors.dart';
import '../utils/validator.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_circular_button.dart';
import '../widgets/custom_text_field.dart';


class RegisterScreen extends StatefulWidget {
  final String? emailAddress;

  const RegisterScreen({super.key, this.emailAddress});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  String username = "";
  String errorUsername = "";

  TextEditingController emailAddressController = TextEditingController();
  String emailAddress = "";
  String errorEmailAddress = "";

  TextEditingController passwordController = TextEditingController();
  String password = "";
  String errorPassword = "";

  @override
  void initState() {
    super.initState();
    emailAddressController.text = widget.emailAddress?? "";
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: AppColors.secondary,
        body: SingleChildScrollView(
            padding: EdgeInsets.only(top: screenHeight * 0.2),
            child: Container(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white1,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                      ),
                      width: screenWidth,
                      height: screenHeight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.06, horizontal: screenWidth * 0.06),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Text("Register", style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 30
                                ),),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomTextField(
                                        controller: usernameController,
                                        icon: Icons.person,
                                        iconSize: 20,
                                        iconColor: AppColors.blue800,
                                        inputColor: AppColors.white2,
                                        iconBackgroundColor: AppColors.blue100,
                                        placeholder: "Username",
                                        screenWidth: screenWidth,
                                        type: TextInputType.text,
                                        onChanged: (value) {
                                          setState(() {
                                            username = value;
                                            errorUsername = Validator.validateUsername(username: username);
                                          });
                                        },
                                      ),
                                      SizedBox(height: 2,),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Text(errorUsername, style: TextStyle(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18
                                        ),),
                                      ),
                                      SizedBox(height: 10,),
                                      CustomTextField(
                                        controller: emailAddressController,
                                        icon: Icons.email_rounded,
                                        iconColor: AppColors.green800,
                                        inputColor: AppColors.white2,
                                        iconBackgroundColor: AppColors.green100,
                                        placeholder: "Enter your email to continue..",
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
                                        padding: EdgeInsets.only(left: 20),
                                        child: Text(errorEmailAddress, style: TextStyle(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18
                                        ),),
                                      ),
                                      SizedBox(height: 10,),
                                      CustomTextField(
                                        controller: passwordController,
                                        icon: Icons.lock,
                                        iconColor: AppColors.purple950,
                                        inputColor: AppColors.white2,
                                        iconBackgroundColor: AppColors.purple100,
                                        placeholder: "Password",
                                        screenWidth: screenWidth,
                                        type: TextInputType.text,
                                        obscure: true,
                                        onChanged: (value) {
                                          setState(() {
                                            password = value;
                                            errorPassword = Validator.validatePassword(password: password);
                                          });
                                        },
                                      ),
                                      SizedBox(height: 2,),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Text(errorPassword, style: TextStyle(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18
                                        ),),
                                      ),
                                    ],
                                  ),),

                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(LoginScreen());
                                        },
                                        child: Text("I have an account?", style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            decoration: TextDecoration.underline
                                        ),),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenHeight / 20,),
                                  CustomButton(
                                      width: double.infinity,
                                      height: 50,
                                      text: "Register",
                                      onTap: () {}
                                  )
                                ],
                            ),
                            SizedBox(height: screenHeight / 14),
                            CustomCircularButton(
                                child: SvgPicture.asset("assets/images/google.svg", width: 30, height: 30,)
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
            )
        )
    );
  }
}
