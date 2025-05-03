import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:hessa/features/auth/presentation/views/widgets/otp_form.dart';
import 'package:hessa/generated/l10n.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/widgets/custom_button.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key, required this.emailAddress});

  final String emailAddress;
  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: SvgPicture.asset("assets/images/Logo-white.svg"),
            ),
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    constraints: BoxConstraints(minHeight: screenHeight),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.06,
                        vertical: screenHeight * 0.03,
                      ),
                      child: Column(
                        spacing: 30,
                        children: [
                          Text(
                            S.of(context).verification,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 23,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: S.of(context).verificationText,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: " $emailAddress .",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          OtpForm(
                            otpController: otpController,
                            formKey: formKey,
                          ),
                          CustomButton(
                            width: 150,
                            height: 50,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            textColor: AppColors.backgroundColorLight,
                            text: S.of(context).verifyButton,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {}
                            },
                          ),
                        ],
                      ),
                    ),
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
