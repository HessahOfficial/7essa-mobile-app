import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';

import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/features/auth/data/models/login_request.dart';
import 'package:hessa/features/auth/presentation/managers/auth_bloc.dart';
import 'package:hessa/features/auth/presentation/views/widgets/google_login_button.dart';
import 'package:hessa/features/auth/presentation/views/widgets/login_form.dart';
import 'package:hessa/generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();

  final emailAddressFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool emailTouched = false;
  bool passwordTouched = false;

  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();

    formKey = GlobalKey<FormState>();

    emailAddressFocusNode.addListener(() {
      if (emailAddressFocusNode.hasFocus) {
        setState(() {
          emailTouched = true;
        });
      }
    });

    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        setState(() {
          passwordTouched = true;
        });
      }
    });
  }

  @override
  void dispose() {
    emailAddressController.dispose();
    passwordController.dispose();

    emailAddressFocusNode.dispose();
    passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    void loginUser() {
      BlocProvider.of<AuthBloc>(context).add(
        LoginEvent(
          request: LoginRequest(
            email: emailAddressController.text,
            password: passwordController.text,
          ),
        ),
      );
    }

    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (bccontext, state) {
            if (state is LoginSuccess) {
              context.go(AppRoutes.mainView);
            } else if (state is LoginFailure) {
              showSnackBar(context: context, message: state.message, type: 1);
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
                                  color: isDark ? Colors.white : Colors.black,
                                  fontSize: 23,
                                ),
                              ),
                              LoginForm(
                                emailAddressController: emailAddressController,
                                passwordController: passwordController,
                                emailAddressFocusNode: emailAddressFocusNode,
                                passwordFocusNode: passwordFocusNode,
                                emailTouched: emailTouched,
                                passwordTocuhed: passwordTouched,
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
                                        color:
                                            isDark
                                                ? Colors.white
                                                : Colors.black,
                                        fontWeight: FontWeight.w800,
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            isDark
                                                ? Colors.white
                                                : Colors.black,
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
                                            isDark
                                                ? Colors.white
                                                : Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                        fontWeight: FontWeight.w800,
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            isDark
                                                ? Colors.white
                                                : Colors.black,
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
