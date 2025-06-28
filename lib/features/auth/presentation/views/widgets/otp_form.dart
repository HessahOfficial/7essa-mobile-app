import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/validator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({
    super.key,
    required this.otpController,
    required this.formKey,
    this.cursorColor,
  });

  final TextEditingController otpController;
  final GlobalKey<FormState> formKey;
  final Color? cursorColor;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Form(
        key: formKey,
        child: PinCodeTextField(
          appContext: context,
          length: 6,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: otpController,
          enablePinAutofill: true,
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
            activeColor: AppColors.lightGreen,
            selectedColor: Theme.of(context).colorScheme.primary,
          ),
          cursorColor: cursorColor ?? Colors.black,
          autoDismissKeyboard: true,
          animationType: AnimationType.slide,
          hintCharacter: "0",

          validator: (value) {
            return Validator(context: context).validatePin(otp: value);
          },
        ),
      ),
    );
  }
}
