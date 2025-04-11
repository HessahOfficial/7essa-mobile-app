import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../utils/validator.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../screens/otp-screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  String emailAddress = "";
  String errorEmailAddress = "";

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _showEmailSentDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pop();
          Get.to(() => const OtpScreen());
        });

        return Center(
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 16), // Ensure it fits on smaller screens
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: ModalRoute.of(context)!.animation!,
                curve: Curves.easeInOut,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.green800,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.email_rounded,
                      color: Colors.white,
                      size: 48,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Check your email",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "A verification code has been sent to $emailAddress",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Blue section with logo
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/Logo-white.svg"),
                ],
              ),
            ),
            // White section with input
            Container(
              decoration: const BoxDecoration(
                color: AppColors.white1,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              width: screenWidth,
              height: screenHeight,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.06,
                  horizontal: screenWidth * 0.06,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Reset Password",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    CustomTextField(
                      controller: emailController,
                      icon: Icons.email_rounded,
                      iconColor: AppColors.green800,
                      inputColor: AppColors.white2,
                      iconBackgroundColor: AppColors.green100,
                      placeholder: "Enter your email",
                      screenWidth: screenWidth,
                      type: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          emailAddress = value;
                          errorEmailAddress = Validator.validateEmailAddress(email: emailAddress);
                        });
                      },
                      // borderColor: errorEmailAddress.isNotEmpty ? Colors.redAccent : null,
                    ),
                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          errorEmailAddress,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    CustomButton(
                      width: 150,
                      height: 50,
                      text: "Submit",
                      onTap: () {
                        if (emailController.text.isNotEmpty && errorEmailAddress.isEmpty) {
                          _showEmailSentDialog();
                        } else {
                          Get.snackbar(
                            "Error",
                            "Please enter a valid email",
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.redAccent,
                            colorText: Colors.white,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}