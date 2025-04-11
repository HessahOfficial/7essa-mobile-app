import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  String enteredOtp = "";
  bool isResendEnabled = true;
  int countdownSeconds = 60;

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _submitOtp() {
    enteredOtp = _controllers.map((controller) => controller.text).join();
    if (enteredOtp.length == 6) {
      const correctOtp = "123456"; // Mock OTP; replace with backend check
      if (enteredOtp == correctOtp) {
        Get.snackbar(
          "Success",
          "OTP verified!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.green800,
          colorText: Colors.white,
        );
        // Navigate to next screen, e.g., Get.to(() => NextScreen());
      } else {
        Get.snackbar(
          "Error",
          "Incorrect OTP",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        _clearControllers();
        _focusNodes[0].requestFocus();
      }
    } else {
      Get.snackbar(
        "Error",
        "Please enter all 6 digits",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  void _clearControllers() {
    for (var controller in _controllers) {
      controller.clear();
    }
    enteredOtp = "";
  }

  void _resendOtp() {
    if (isResendEnabled) {
      _clearControllers();
      _focusNodes[0].requestFocus();
      Get.snackbar(
        "Resent",
        "New OTP sent!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.green800,
        colorText: Colors.white,
      );
      // Add backend call to resend OTP if needed

      // Start countdown
      setState(() {
        isResendEnabled = false;
        countdownSeconds = 60;
      });

      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            countdownSeconds--;
            if (countdownSeconds > 0) {
              _startCountdown();
            } else {
              isResendEnabled = true;
            }
          });
        }
      });
    }
  }

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && countdownSeconds > 0) {
        setState(() {
          countdownSeconds--;
          if (countdownSeconds > 0) {
            _startCountdown();
          } else {
            isResendEnabled = true;
          }
        });
      }
    });
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
            // White section with OTP input
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
                      "Enter OTP",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) {
                        return SizedBox(
                          width: 50,
                          height: 60,
                          child: TextField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: AppColors.blue800, // Blue border
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: AppColors.blue800, // Blue border
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: AppColors.blue800, // Blue border, thicker
                                  width: 2.0,
                                ),
                              ),
                              counterText: '',
                              contentPadding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                            onChanged: (value) {
                              if (value.length == 1) {
                                // Move to next field
                                if (index < 5) {
                                  FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                                } else {
                                  _focusNodes[index].unfocus();
                                  _submitOtp();
                                }
                              } else if (value.isEmpty) {
                                // Move to previous field on delete
                                if (index > 0) {
                                  FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                                }
                                enteredOtp = _controllers.map((c) => c.text).join();
                              }
                            },
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: isResendEnabled ? _resendOtp : null,
                          splashColor: AppColors.blue100.withOpacity(0.3),
                          highlightColor: AppColors.blue800.withOpacity(0.1),
                          child: Text(
                            "Resend OTP",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              color: isResendEnabled ? AppColors.blue800 : Colors.grey,
                            ),
                          ),
                        ),
                        if (!isResendEnabled) ...[
                          const SizedBox(width: 8),
                          Text(
                            "($countdownSeconds s)",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.blue800,
                            ),
                          ),
                        ],
                      ],
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