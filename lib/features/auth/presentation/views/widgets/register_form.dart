import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/validator.dart';
import 'package:hessa/core/widgets/custom_text_field.dart';
import 'package:hessa/generated/l10n.dart';

class RegisterForm extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController firstnameController;
  final TextEditingController lastnameController;
  final TextEditingController emailAddressController;
  final TextEditingController passwordController;

  final FocusNode usernameFocusNode;
  final FocusNode firstnameFocusNode;
  final FocusNode lastnameFocusNode;
  final FocusNode emailAddressFocusNode;
  final FocusNode passwordFocusNode;

  final bool usernameTouched;
  final bool firstnameTouched;
  final bool lastnameTouched;
  final bool emailTouched;
  final bool passwordTouched;

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
    required this.usernameFocusNode,
    required this.firstnameFocusNode,
    required this.lastnameFocusNode,
    required this.emailAddressFocusNode,
    required this.passwordFocusNode,
    required this.usernameTouched,
    required this.firstnameTouched,
    required this.lastnameTouched,
    required this.emailTouched,
    required this.passwordTouched,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late bool visible;

  @override
  void initState() {
    visible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        spacing: 15,
        children: [
          CustomTextField(
            controller: widget.firstnameController,
            icon: Icons.person,
            inputColor: AppColors.white2,
            placeholder: S.of(context).firstNamePLaceholder,
            type: TextInputType.name,
            validator: (value) {
              return Validator(
                context: context,
              ).validateUsername(username: value!);
            },
          ),
          CustomTextField(
            controller: widget.lastnameController,
            icon: Icons.person,
            inputColor: AppColors.white2,
            placeholder: S.of(context).lastNamePLaceholder,
            type: TextInputType.name,
            validator: (value) {
              return Validator(
                context: context,
              ).validateUsername(username: value!);
            },
          ),
          CustomTextField(
            controller: widget.usernameController,
            icon: Icons.person,
            iconSize: 20,
            inputColor: AppColors.white2,
            placeholder: S.of(context).usernamePlaceholder,
            type: TextInputType.text,
            validator: (value) {
              return Validator(
                context: context,
              ).validateUsername(username: value!);
            },
          ),
          CustomTextField(
            controller: widget.emailAddressController,
            icon: Icons.email_rounded,
            inputColor: AppColors.white2,
            placeholder: S.of(context).emailPlaceholder,
            type: TextInputType.emailAddress,
            validator: (value) {
              return Validator(
                context: context,
              ).validateEmailAddress(email: value!);
            },
          ),
          CustomTextField(
            focusNode: widget.passwordFocusNode,
            fieldTocuhed: widget.passwordTouched,
            controller: widget.passwordController,
            icon: Icons.lock,
            inputColor: AppColors.white2,
            placeholder: S.of(context).passwordPlaceholder,
            type: TextInputType.text,
            obscure: !visible,
            suffixIcon: visible ? Icons.visibility : Icons.visibility_off,
            suffixFunction:
                () => setState(() {
                  visible = !visible;
                }),
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
