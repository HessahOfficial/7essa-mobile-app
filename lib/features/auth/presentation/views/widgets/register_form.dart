import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/validator.dart';
import 'package:hessa/core/widgets/custom_text_field.dart';
import 'package:hessa/generated/l10n.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController firstnameController;
  final TextEditingController lastnameController;
  final TextEditingController emailAddressController;
  final TextEditingController passwordController;
  final double screenWidth;
  final GlobalKey<FormState> formKey;

  const RegisterForm({
    super.key,
    required this.usernameController,
    required this.emailAddressController,
    required this.passwordController,
    required this.screenWidth,
    required this.formKey,
    required this.firstnameController,
    required this.lastnameController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        spacing: 15,
        children: [
          CustomTextField(
            controller: firstnameController,
            icon: Icons.person,
            iconColor: AppColors.orange950,
            inputColor: AppColors.white2,
            iconBackgroundColor: AppColors.orange100,
            placeholder: "Firstname",
            screenWidth: screenWidth,
            type: TextInputType.name,
            validator: (value) {
              return Validator(
                context: context,
              ).validateUsername(username: value!);
            },
          ),
          CustomTextField(
            controller: lastnameController,
            icon: Icons.person,
            iconColor: AppColors.orange950,
            inputColor: AppColors.white2,
            iconBackgroundColor: AppColors.orange100,
            placeholder: "Lastname",
            screenWidth: screenWidth,
            type: TextInputType.name,
            validator: (value) {
              return Validator(
                context: context,
              ).validateUsername(username: value!);
            },
          ),
          CustomTextField(
            controller: usernameController,
            icon: Icons.person,
            iconSize: 20,
            iconColor: AppColors.blue800,
            inputColor: AppColors.white2,
            iconBackgroundColor: AppColors.blue100,
            placeholder: S.of(context).usernamePlaceholder,
            screenWidth: screenWidth,
            type: TextInputType.text,
            validator: (value) {
              return Validator(
                context: context,
              ).validateUsername(username: value!);
            },
          ),
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
