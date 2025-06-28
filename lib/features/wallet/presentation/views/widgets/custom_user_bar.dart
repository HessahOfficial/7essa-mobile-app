import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';
import 'package:hessa/features/auth/presentation/managers/auth_bloc.dart';

class CustomUserBar extends StatelessWidget {
  final BuildContext screenContext;

  const CustomUserBar({super.key, required this.screenContext});

  @override
  Widget build(BuildContext context) {
    UserModel currentUser = getIt.get<HiveHelper>().currentUser!;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (bccontext, state) {
        if (state is RefreshTokenFailure) {
          context.go(AppRoutes.loginView);
        }
      },
      builder: (bccontext, state) {
        return Row(
          spacing: 10,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                image: NetworkImage(currentUser.avatar!),
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentUser.username!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    currentUser.email!,
                    style: TextStyle(
                      color: AppColors.gray,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
