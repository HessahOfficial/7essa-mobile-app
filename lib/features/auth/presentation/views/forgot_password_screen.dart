import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';

import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/features/auth/data/models/forgot_password_request.dart';
import 'package:hessa/features/auth/presentation/managers/auth_bloc.dart';
import 'package:hessa/features/auth/presentation/views/widgets/forgot_password_form.dart';
import 'package:hessa/generated/l10n.dart';

// ignore: must_be_immutable
class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailAddressController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    void forgotUserPassword() {
      BlocProvider.of<AuthBloc>(context).add(
        ForgotPasswordEvent(
          request: ForgotPasswordRequest(email: emailAddressController.text),
        ),
      );
    }

    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (bccontext, state) {
            if (state is ForgotPasswordFailure) {
              print("Error: ${state.message}");
            } else if (state is ForgotPasswordSuccess) {
              print("Success: ${state.response.message}");
              context.push(
                AppRoutes.otpView,
                extra: {"emailAddress": emailAddressController.text},
              );
            }
          },
          builder: (bccontext, state) {
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: SvgPicture.asset("assets/images/Logo-white.svg"),
                ),
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Container(
                        constraints: BoxConstraints(minHeight: screenHeight),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.06,
                            vertical: screenHeight * 0.03,
                          ),
                          child: Column(
                            spacing: 30,
                            children: [
                              Text(
                                S.of(context).forgot,
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 23,
                                ),
                              ),
                              Text(
                                S.of(context).forgotPasswordText,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              ForgotPasswordForm(
                                emailAddressController: emailAddressController,
                                screenWidth: screenWidth,
                                formKey: formKey,
                              ),
                              state is ForgotPasswordLoading
                                  ? CircularProgressIndicator(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )
                                  : CustomButton(
                                    width: 150,
                                    height: 50,
                                    textColor: AppColors.backgroundColorLight,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    text: S.of(context).sendButton,
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        forgotUserPassword();
                                      }
                                    },
                                  ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
