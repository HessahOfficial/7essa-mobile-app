import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/features/auth/presentation/views/widgets/otp_form.dart';
import 'package:hessa/features/settings/data/models/change_pin_request.dart';
import 'package:hessa/features/settings/presentation/managers/user_bloc.dart';
import 'package:hessa/generated/l10n.dart';

class CustomPinDialog extends StatelessWidget {
  final otpController = TextEditingController();

  final otpFocusNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey();

  CustomPinDialog({super.key});

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
                S.of(context).pinMessage,
                textAlign: TextAlign.center,
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
                        context.read<UserBloc>().add(
                          ChangePinEvent(
                            request: ChangePinRequest(
                              pin: int.parse(otpController.text),
                            ),
                          ),
                        );
                        context.pop();
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
