import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/validator.dart';
import 'package:hessa/core/widgets/custom_text_field.dart';
import 'package:hessa/generated/l10n.dart';

class ForgotPasswordForm extends StatelessWidget {
  final TextEditingController emailAddressController;
  final FocusNode emailAddressFocusNode;
  final bool emailTouched;
  final double screenWidth;
  final GlobalKey<FormState> formKey;

  const ForgotPasswordForm({
    super.key,
    required this.emailAddressController,
    required this.screenWidth,
    required this.formKey,
    required this.emailAddressFocusNode,
    required this.emailTouched,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            fieldTocuhed: emailTouched,
            focusNode: emailAddressFocusNode,
            controller: emailAddressController,
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
        ],
      ),
    );
  }
}
