import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/validator.dart';
import 'package:hessa/core/widgets/custom_text_field.dart';
import 'package:hessa/generated/l10n.dart';

class ForgotPasswordForm extends StatelessWidget {
  final TextEditingController emailAddressController;
  final double screenWidth;
  final GlobalKey<FormState> formKey;

  const ForgotPasswordForm({
    super.key,
    required this.emailAddressController,
    required this.screenWidth,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: emailAddressController,
            icon: Icons.email_rounded,
            iconColor: AppColors.green800,
            inputColor: AppColors.white2,
            iconBackgroundColor: AppColors.green100,
            placeholder: S.of(context).emailPlaceholder,
            screenWidth: screenWidth,
            type: TextInputType.emailAddress,
            validator: (value) {
              return Validator(
                context: context,
              ).validateEmailAddress(email: value!);
            },
          ),
        ],
      ),
    );
  }
}
