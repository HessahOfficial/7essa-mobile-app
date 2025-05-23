import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/validator.dart';
import 'package:hessa/core/widgets/custom_text_field.dart';
import 'package:hessa/generated/l10n.dart';

class LoginForm extends StatefulWidget {
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: widget.formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: widget.emailAddressController,
            icon: Icons.email_rounded,
            iconColor: AppColors.green800,
            inputColor: AppColors.white2,
            iconBackgroundColor: AppColors.green100,
            placeholder: S.of(context).emailPlaceholder,
            screenWidth: widget.screenWidth,
            type: TextInputType.emailAddress,
            validator: (value) {
              return Validator(
                context: context,
              ).validateEmailAddress(email: value!);
            },
          ),
          SizedBox(height: 15),
          CustomTextField(
            controller: widget.passwordController,
            icon: Icons.lock,
            iconColor: AppColors.purple950,
            inputColor: AppColors.white2,
            iconBackgroundColor: AppColors.purple100,
            placeholder: S.of(context).passwordPlaceholder,
            screenWidth: widget.screenWidth,
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
