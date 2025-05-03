import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';

import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/features/auth/presentation/managers/auth_bloc.dart';
import 'package:hessa/features/auth/presentation/views/widgets/google_login_button.dart';
import 'package:hessa/features/auth/presentation/views/widgets/login_form.dart';
import 'package:hessa/generated/l10n.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    void loginUser() {
      // BlocProvider.of<AuthBloc>(context).add(
      //   LoginEvent(
      //     request: LoginRequest(
      //       email: emailAddressController.text,
      //       password: passwordController.text,
      //     ),
      //   ),
      // );
    }

    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              context.go(AppRoutes.mainView);
            } else if (state is LoginFailure) {
              print("Error: ${state.message}");
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
                                S.of(context).login,
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 23,
                                ),
                              ),
                              LoginForm(
                                emailAddressController: emailAddressController,
                                passwordController: passwordController,
                                screenWidth: screenWidth,
                                formKey: formKey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap:
                                        () => context.push(
                                          AppRoutes.forgotPasswordView,
                                        ),
                                    child: Text(
                                      S.of(context).forgotPassword,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap:
                                        () => context.push(
                                          AppRoutes.registerView,
                                        ),
                                    child: Text(
                                      S.of(context).registerUser,
                                      style: TextStyle(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              (state is LoginLoading)
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
                                    text: S.of(context).loginButton,
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        loginUser();
                                      }
                                    },
                                  ),
                              GoogleLoginButton(),
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
