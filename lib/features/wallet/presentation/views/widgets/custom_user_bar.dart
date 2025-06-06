import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';
import 'package:hessa/features/settings/data/models/get_info_request.dart';
import 'package:hessa/features/settings/presentation/managers/user_bloc.dart';

class CustomUserBar extends StatefulWidget {
  final BuildContext screenContext;

  const CustomUserBar({super.key, required this.screenContext});

  @override
  State<CustomUserBar> createState() => _CustomUserBarState();
}

class _CustomUserBarState extends State<CustomUserBar> {
  @override
  void initState() {
    final currentUser = getIt.get<HiveHelper>().currentUser;
    context.read<UserBloc>().add(
      GetInfoEvent(request: GetInfoRequest(userId: currentUser!.id!)),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel currentUser = getIt.get<HiveHelper>().currentUser!;

    return BlocConsumer<UserBloc, UserState>(
      listener: (bccontext, state) {
        if (state is UserInfoFailure) {
          showSnackBar(
            context: widget.screenContext,
            message: state.message,
            type: 1,
          );
        }
      },
      builder: (bccontext, state) {
        return Row(
          spacing: 10,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 25,
              child: Image.network(currentUser.avatar!, fit: BoxFit.cover),
            ),
            Column(
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
          ],
        );
      },
    );
  }
}
