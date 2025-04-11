import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:get/get.dart";
import "package:hessa/constants/app_colors.dart";
import "package:hessa/screens/become_investor_screen.dart";
import "package:hessa/screens/home_screen.dart";
import "package:hessa/screens/login-screen.dart";
import "package:hessa/screens/matched_property_screen.dart";
import "package:hessa/screens/profile_screen.dart";
import "package:hessa/screens/register_screen.dart";
import "package:hessa/screens/settings_screen.dart";
import "package:hessa/utils/validator.dart";
import "package:hessa/widgets/custom_button.dart";
import "package:hessa/widgets/custom_circular_button.dart";
import "package:hessa/widgets/custom_text_field.dart";


class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {

  TextEditingController emailAddressController = TextEditingController();
  String emailAddress = "";
  String errorEmailAddress = "";

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
                            Text("Start your investments now!", style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 23
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
                                  ),),),
                                ],
                              ),),
                            CustomButton(
                                width: 150,
                                height: 50,
                                text: "Continue",
                                onTap: () {
                                  // Get.to(HomeScreen());
                                  if (errorEmailAddress.isEmpty && emailAddressController.text.isNotEmpty) {
                                    if (emailAddressController.text == "mostafa3132004@gmail.com") {
                                      Get.to(LoginScreen(emailAddress: emailAddressController.text,));
                                    } else {
                                      Get.to(RegisterScreen(emailAddress: emailAddressController.text,));
                                    }
                                  }
                                }
                            )
                          ],
                        ),
                        SizedBox(height: screenHeight / 4,),
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





