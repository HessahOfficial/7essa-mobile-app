import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/validator.dart';
import 'package:hessa/core/widgets/custom_text_field.dart';
import 'package:hessa/generated/l10n.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailAddressController;
  final TextEditingController passwordController;
  final double screenWidth;
  final GlobalKey<FormState> formKey;

  const LoginForm({
    super.key,
    required this.emailAddressController,
    required this.passwordController,
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
          SizedBox(height: 15),
          CustomTextField(
            controller: passwordController,
            icon: Icons.lock,
            iconColor: AppColors.purple950,
            inputColor: AppColors.white2,
            iconBackgroundColor: AppColors.purple100,
            placeholder: S.of(context).passwordPlaceholder,
            screenWidth: screenWidth,
            type: TextInputType.text,
            obscure: true,
            validator: (value) {
              return Validator(
                context: context,
              ).validatePassword(password: value!);
            },
          ),
        ],
      ),
    );
  }
}
