import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_circular_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    TextEditingController emailAddressController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.secondary,
          body: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(padding: EdgeInsets.symmetric(vertical: screenHeight * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/Logo-white.svg"),
                      ],
                    )
                  )
                ),
                Expanded(
                  flex: 2,
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
                              Text("Login", style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 30
                              ),),
                              //
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.03,
                                ),
                                child: Container(
                                  // color: AppColors.white2,
                                  child: Column(
                                    children: [
                                      customTextField(
                                          controller: emailAddressController,
                                          icon: Icons.email_rounded,
                                          iconColor: AppColors.green800,
                                          inputColor: AppColors.white2,
                                          iconBackgroundColor: AppColors.green100,
                                          placeholder: "example@gmail.com",
                                          screenWidth: screenWidth,
                                          type: TextInputType.emailAddress
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
                                          obscure: true
                                      ),
                                      SizedBox(height: 15,),
                                    ],
                                  ),
                                ),
                              ),

                              Container(
                                width: 350,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("I forgot my password", style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline
                                    ),),

                                    customButton(
                                      width: 150,
                                      height: 50,
                                      text: "Login",
                                      onTap: () {}
                                    ),
                                  ],
                                )
                              ),

                            ],
                          ),
                        ),

                        customCircularButton(
                            child: SvgPicture.asset("assets/images/google.svg", width: 30, height: 30,)
                        )

                      ],
                    ),
                  ))
              ],
            ),
          )
      ),
    );
  }
}
