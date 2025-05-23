import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';

import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/features/contact/presentation/views/widgets/contact_us_form.dart';
import 'package:hessa/generated/l10n.dart';

class ContactUsScreen extends StatelessWidget {
  final TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          leading: InkWell(
            onTap: () => context.pop(),
            splashColor: AppColors.gray.withOpacity(0.1),
            child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          ),
        ),
        body: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: screenHeight * 0.05),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              constraints: BoxConstraints(minHeight: screenHeight),
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.06,
                  right: screenWidth * 0.06,
                  top: screenHeight * 0.02,
                ),
                child: Column(
                  spacing: 20,
                  children: [
                    Text(
                      S.of(context).contactUs,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                      S.of(context).contactUsText,
                    ),
                    Icon(
                      FontAwesomeIcons.envelopesBulk,
                      size: 30,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    ContactUsForm(
                      formKey: formKey,
                      messageController: messageController,
                    ),
                    CustomButton(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      width: 100,
                      height: 50,
                      text: S.of(context).sendButton,
                      textColor: AppColors.backgroundColorLight,
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
    );
  }
}
