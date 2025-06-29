import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';
import 'package:hessa/features/auth/presentation/managers/auth_bloc.dart';
import 'package:hessa/generated/l10n.dart';

class CustomAppBar extends StatefulWidget {
  final BuildContext screenContext;

  const CustomAppBar({super.key, required this.screenContext});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (bccontext, state) {
        if (state is RefreshTokenFailure) {
          context.go(AppRoutes.loginView);
        }
      },
      builder: (bccontext, state) {
        double screenWidth = MediaQuery.of(context).size.width;
        UserModel currentUser = getIt.get<HiveHelper>().currentUser!;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).hello,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: AppColors.gray,
                      ),
                    ),
                    Text(
                      currentUser.username!,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(100),
                splashColor: AppColors.gray.withOpacity(0.1),
                onTap: () => context.push(AppRoutes.notificationsView),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Icon(Icons.notifications_none, size: 28),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
