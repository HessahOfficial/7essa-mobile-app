import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';

import 'package:hessa/cubits/google/google_cubit.dart';
import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/core/widgets/custom_circular_button.dart';

import 'package:hessa/features/auth/data/models/register_request.dart';
import 'package:hessa/features/auth/presentation/managers/auth_bloc.dart';
import 'package:hessa/features/auth/presentation/views/widgets/register_form.dart';
import 'package:hessa/generated/l10n.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    void signUpWithGoogle() async {
      await context.read<GoogleCubit>().signInWithGoogle();
    }

    void registerUser() {
      BlocProvider.of<AuthBloc>(context).add(
        RegisterEvent(
          request: RegisterRequest(
            name: usernameController.text,
            email: emailAddressController.text,
            password: passwordController.text,
            phoneNumber: phoneController.text,
          ),
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
            if (state is RegisterFailure) {
              print("ERROR: ${state.message}");
            }
          },
          builder: (bccontext, state) {
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: screenHeight * 0.15),
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
                  child: Column(
                    children: [
                      Text(
                        S.of(context).register,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(height: 20),
                      RegisterForm(
                        usernameController: usernameController,
                        phoneController: phoneController,
                        emailAddressController: emailAddressController,
                        passwordController: passwordController,
                        screenWidth: screenWidth,
                        formKey: formKey,
                      ),
                      SizedBox(height: 30),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () => context.push(AppRoutes.loginView),
                          child: Text(
                            S.of(context).haveAccount,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
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
