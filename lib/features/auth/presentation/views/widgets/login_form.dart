import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/validator.dart';
import 'package:hessa/core/widgets/custom_text_field.dart';
import 'package:hessa/generated/l10n.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailAddressController;
  final TextEditingController passwordController;
  final FocusNode emailAddressFocusNode;
  final FocusNode passwordFocusNode;
  final bool emailTouched;
  final bool passwordTocuhed;
  final double screenWidth;
  final GlobalKey<FormState> formKey;

  const LoginForm({
    super.key,
    required this.emailAddressController,
    required this.passwordController,
    required this.screenWidth,
    required this.formKey,
    required this.emailAddressFocusNode,
    required this.passwordFocusNode,
    required this.emailTouched,
    required this.passwordTocuhed,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
            focusNode: widget.emailAddressFocusNode,
            fieldTocuhed: widget.emailTouched,
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
            fieldTocuhed: widget.passwordTocuhed,
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
