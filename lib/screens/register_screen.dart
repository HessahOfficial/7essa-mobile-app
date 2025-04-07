import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hessa/screens/login-screen.dart';

import '../constants/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_circular_button.dart';
import '../widgets/custom_text_field.dart';


class RegisterScreen extends StatefulWidget {
  final String emailAddress;

  const RegisterScreen({super.key, required this.emailAddress});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    TextEditingController usernameController = TextEditingController();
    TextEditingController emailAddressController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.secondary,
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container()
                ),
                Expanded(
                    flex: 4,
                    child: Container(
                      width: screenWidth,
                      decoration: BoxDecoration(
                        color: AppColors.white1,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: screenHeight * 0.01),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text("Register", style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 30
                                  ),),),
                                //
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.03,
                                  ),
                                  child: Column(
                                    children: [
                                      customTextField(
                                        controller: usernameController,
                                        icon: Icons.person_rounded,
                                        iconColor: AppColors.blue800,
                                        inputColor: AppColors.white2,
                                        iconBackgroundColor: AppColors.blue100,
                                        placeholder: "Username",
                                        screenWidth: screenWidth,
                                        type: TextInputType.text,
                                        iconSize: 22,
                                        // onChanged: (val) {
                                        //   setState(() {
                                        //     usernameController.text = val;
                                        //   });
                                        // }
                                      ),
                                      SizedBox(height: 15,),
                                      customTextField(
                                        controller: emailAddressController,
                                        icon: Icons.email_rounded,
                                        iconColor: AppColors.green800,
                                        inputColor: AppColors.white2,
                                        iconBackgroundColor: AppColors.green100,
                                        placeholder: "example@gmail.com",
                                        screenWidth: screenWidth,
                                        type: TextInputType.emailAddress,
                                        // onChanged: (val) {
                                        //   setState(() {
                                        //     emailAddressController.text = val;
                                        //   });
                                        // }
                                      ),
                                      SizedBox(height: 15,),
                                      customTextField(
                                        controller: passwordController,
                                        icon: Icons.lock,
                                        iconColor: AppColors.purple950,
                                        inputColor: AppColors.white2,
                                        iconBackgroundColor: AppColors.purple100,
                                        placeholder: "Password",
                                        screenWidth: screenWidth,
                                        type: TextInputType.text,
                                        obscure: true,
                                        // onChanged: (val) {
                                        //   setState(() {
                                        //     passwordController.text = val;
                                        //   });
                                        // }
                                      ),
                                      SizedBox(height: 40,),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              child: Text("I have an account ?", style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  decoration: TextDecoration.underline
                                              ),),
                                              onTap: () {
                                                Get.to(LoginScreen(emailAddress: widget.emailAddress));
                                              },
                                            ),
                                          ],
                                        ),)
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),

                          customButton(
                              width: 362.1,
                              height: 50,
                              text: "Register",
                              onTap: () {}
                          ),

                          customCircularButton(
                              child: SvgPicture.asset("assets/images/google.svg", width: 30, height: 30,)
                          )

                        ],
                      ),
                    )
                )
              ],
          ),
      ),
    );
  }
}
