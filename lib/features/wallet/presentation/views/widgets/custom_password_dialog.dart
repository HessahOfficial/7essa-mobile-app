import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/features/auth/presentation/views/widgets/otp_form.dart';
import 'package:hessa/features/wallet/presentation/managers/balance_cubit.dart';
import 'package:hessa/generated/l10n.dart';

class CustomPasswordDialog extends StatelessWidget {
  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  CustomPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 5),
            ],
          ),
          child: Column(
            spacing: 20,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                S.of(context).passowrdDialog,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              OtpForm(
                otpController: otpController,
                formKey: formKey,
                cursorColor: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    width: 100,
                    height: 40,
                    text: S.of(context).cancel,
                    backgroundColor: Colors.transparent,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CustomButton(
                    width: 100,
                    height: 40,
                    text: S.of(context).submit,
                    textColor: AppColors.backgroundColorLight,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<BalanceCubit>().validatePassword(
                          password: otpController.text,
                          context: context,
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
