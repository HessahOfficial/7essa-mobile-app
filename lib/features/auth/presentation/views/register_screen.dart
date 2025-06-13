import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';

import 'package:hessa/cubits/google/google_cubit.dart';
import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/core/widgets/custom_circular_button.dart';

import 'package:hessa/features/auth/data/models/register_request.dart';
import 'package:hessa/features/auth/data/models/verify_email_request.dart';
import 'package:hessa/features/auth/presentation/managers/auth_bloc.dart';
import 'package:hessa/features/auth/presentation/views/widgets/register_form.dart';
import 'package:hessa/features/settings/presentation/views/widgets/custom_info_popup.dart';
import 'package:hessa/generated/l10n.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();

  final usernameFocusNode = FocusNode();
  final firstnameFocusNode = FocusNode();
  final lastnameFocusNode = FocusNode();
  final emailAddressFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool usernameTouched = false;
  bool firstnameTouched = false;
  bool lastnameTouched = false;
  bool emailTouched = false;
  bool passwordTouched = false;

  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();

    formKey = GlobalKey<FormState>();

    usernameFocusNode.addListener(() {
      if (usernameFocusNode.hasFocus) {
        setState(() {
          usernameTouched = true;
        });
      }
    });

    firstnameFocusNode.addListener(() {
      if (firstnameFocusNode.hasFocus) {
        setState(() {
          firstnameTouched = true;
        });
      }
    });

    lastnameFocusNode.addListener(() {
      if (lastnameFocusNode.hasFocus) {
        setState(() {
          lastnameTouched = true;
        });
      }
    });

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
    usernameController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    passwordController.dispose();

    emailAddressFocusNode.dispose();
    usernameFocusNode.dispose();
    firstnameFocusNode.dispose();
    lastnameFocusNode.dispose();
    passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    void signUpWithGoogle() async {
      await context.read<GoogleCubit>().signInWithGoogle();
    }

    void registerUser() {
      if (formKey.currentState!.validate()) {
        context.read<AuthBloc>().add(
          RegisterEvent(
            request: RegisterRequest(
              username: usernameController.text,
              email: emailAddressController.text,
              password: passwordController.text,
              firstName: firstnameController.text,
              lastName: lastnameController.text,
            ),
          ),
        );
      }
    }

    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (bccontext, state) {
            if (state is RegisterFailure) {
              showSnackBar(context: context, message: state.message, type: 1);
            } else if (state is VerifyEmailFailure) {
              showSnackBar(context: context, message: state.message, type: 1);
            } else if (state is VerifyEmailSuccess) {
              showSnackBar(
                context: context,
                message: S.of(context).verificationEmailSent,
                type: 0,
              );
            } else if (state is RegisterSuccess) {
              showDialog(
                context: context,
                builder:
                    (context) => CustomInfoPopup(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                          VerifyEmailEvent(
                            request: VerifyEmailRequest(
                              email: emailAddressController.text,
                            ),
                          ),
                        );
                        context.pop();
                      },
                      width: 220,
                      height: 170,
                      icon: Icons.info,
                      message: S.of(context).verificationText,
                    ),
              );
            }
          },
          builder: (bccontext, state) {
            return Container(
              margin: EdgeInsets.only(top: screenHeight * 0.1),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              constraints: BoxConstraints(minHeight: screenHeight),
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.06,
                  right: screenWidth * 0.06,
                  top: screenHeight * 0.02,
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    spacing: 20,
                    children: [
                      Text(
                        S.of(context).register,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: isDark ? Colors.white : Colors.black,
                          fontSize: 30,
                        ),
                      ),
                      RegisterForm(
                        usernameController: usernameController,
                        firstnameController: firstnameController,
                        lastnameController: lastnameController,
                        emailAddressController: emailAddressController,
                        passwordController: passwordController,
                        emailAddressFocusNode: emailAddressFocusNode,
                        passwordFocusNode: passwordFocusNode,
                        usernameFocusNode: usernameFocusNode,
                        firstnameFocusNode: firstnameFocusNode,
                        lastnameFocusNode: lastnameFocusNode,
                        emailTouched: emailTouched,
                        usernameTouched: usernameTouched,
                        firstnameTouched: firstnameTouched,
                        lastnameTouched: lastnameTouched,
                        passwordTouched: passwordTouched,
                        screenWidth: screenWidth,
                        formKey: formKey,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () => context.push(AppRoutes.loginView),
                          child: Text(
                            S.of(context).haveAccount,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: isDark ? Colors.white : Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      state is RegisterLoading
                          ? CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary,
                          )
                          : CustomButton(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            width: double.infinity,
                            height: 50,
                            text: S.of(context).registerButton,
                            textColor: AppColors.backgroundColorLight,
                            onPressed: registerUser,
                          ),
                      SizedBox(height: 30),
                      CustomCircularButton(
                        onTap: signUpWithGoogle,
                        child: SvgPicture.asset(
                          "assets/images/google.svg",
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
