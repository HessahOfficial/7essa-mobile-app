import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/features/auth/data/models/verify_email_request.dart';
import 'package:hessa/features/auth/presentation/managers/auth_bloc.dart';
import 'package:hessa/generated/l10n.dart';

class RegisterCtaScreen extends StatelessWidget {
  final String email;

  const RegisterCtaScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (bccontext, state) {
        if (state is VerifyEmailFailure) {
          showSnackBar(context: context, message: state.message, type: 1);
        } else if (state is VerifyEmailSuccess) {
          showSnackBar(
            context: context,
            message: S.of(context).verificationEmailSent,
            type: 0,
          );
        }
      },
      builder: (bccontext, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 25,
              children: [
                Icon(Icons.email, color: AppColors.newAddedColor, size: 120),
                Text(
                  S.of(context).verificationText,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      onPressed:
                          () => context.read<AuthBloc>().add(
                            VerifyEmailEvent(
                              request: VerifyEmailRequest(email: email),
                            ),
                          ),
                      width: 100,
                      height: 50,
                      text: S.of(context).sendButton,
                      textColor: Colors.white,
                    ),
                    InkWell(
                      onTap: () => context.go(AppRoutes.loginView),
                      child: Text(
                        S.of(context).login,
                        style: TextStyle(
                          color:
                              isDark
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
