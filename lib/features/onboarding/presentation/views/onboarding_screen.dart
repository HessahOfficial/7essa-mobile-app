import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';

import 'package:hessa/core/widgets/custom_text_button.dart';
import 'package:hessa/features/onboarding/presentation/managers/launch_cubit.dart';
import 'package:hessa/generated/l10n.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<LaunchCubit, LaunchState>(
      listener: (bccontext, state) {
        if (state is LaunchActive) {
          context.go(AppRoutes.loginView);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.1),
                child: Column(
                  children: [
                    SvgPicture.asset("assets/images/invest.svg"),
                    SizedBox(height: 70),
                    Center(
                      child: Text(
                        S.of(context).onboardingTitle,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextButton(
                    text: S.of(context).skip,
                    color: AppColors.gray,
                    onTap:
                        () => context.read<LaunchCubit>().launch(
                          context: context,
                        ),
                  ),
                  CustomTextButton(
                    text: S.of(context).next,
                    onTap:
                        () => context.read<LaunchCubit>().launch(
                          context: context,
                        ),
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
