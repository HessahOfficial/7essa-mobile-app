import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/routes/app_routes.dart';

import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/cubits/google/google_cubit.dart';
import 'package:hessa/features/auth/presentation/managers/auth_bloc.dart';
import 'package:hessa/features/settings/presentation/views/widgets/locale_switch.dart';
import 'package:hessa/features/settings/presentation/views/widgets/setting_item.dart';
import 'package:hessa/features/settings/presentation/views/widgets/terms_and_conditions.dart';
import 'package:hessa/features/settings/presentation/views/widgets/theme_switch.dart';
import 'package:hessa/generated/l10n.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isGoogleAuth = getIt.get<HiveHelper>().isGoogleAuth ?? false;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          S.of(context).settings,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (bcccontext, state) {
          if (state is LogoutSuccess) {
            context.go(AppRoutes.loginView);
          }
        },
        builder: (bcccontext, state) {
          return BlocConsumer<GoogleCubit, GoogleState>(
            listener: (bccontext, state) {
              if (state is GoogleSignOutFailure) {
                showSnackBar(context: context, message: state.message, type: 1);
              } else if (state is GoogleSignOutSuccess) {
                context.replace(AppRoutes.loginView);
              }
            },
            builder: (bccontext, state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SettingItem(
                          title: S.of(context).profileSettings,
                          backgroundColor: AppColors.orange,
                          icon: Icons.person,
                          onTap: () => context.push(AppRoutes.profileView),
                        ),
                        SettingItem(
                          title: S.of(context).contactUs,
                          backgroundColor: AppColors.purple,
                          icon: Icons.alternate_email_rounded,
                          onTap: () => context.push(AppRoutes.contactUsView),
                        ),
                        SettingItem(
                          title: S.of(context).notifications,
                          backgroundColor: AppColors.skyBlue,
                          icon: Icons.notifications,
                          onTap:
                              () => context.push(AppRoutes.notificationsView),
                        ),
                        SettingItem(
                          title: S.of(context).logout,
                          backgroundColor: AppColors.skyBlue300,
                          iconWidget: FaIcon(
                            FontAwesomeIcons.doorOpen,
                            size: 15,
                            color: Colors.black,
                          ),
                          onTap: () {
                            context.read<AuthBloc>().add(LogoutEvent());
                          },
                        ),
                        ThemeSwitch(title: S.of(context).darkmode),
                        LocaleSwitch(title: S.of(context).locale),
                        TermsAndConditions(),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
