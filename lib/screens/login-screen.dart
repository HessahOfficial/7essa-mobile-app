import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_colors.dart';
import '../utils/validator.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_circular_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  final String? emailAddress;

  const LoginScreen({super.key, this.emailAddress});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

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
            child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.1),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/images/Logo-white.svg"),
                          ]
                      ),),
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
                                Text("Login", style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 30
                                ),),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("I forgot my password", style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline
                                    ),),

                                    CustomButton(
                                        width: 150,
                                        height: 50,
                                        text: "Login",
                                        onTap: () {}
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: screenHeight / 8),
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
