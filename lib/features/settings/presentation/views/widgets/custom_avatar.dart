import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';
import 'package:hessa/features/settings/presentation/managers/user_bloc.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel currentUser = getIt.get<HiveHelper>().currentUser!;
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return BlocBuilder<UserBloc, UserState>(
      builder: (bccontext, state) {
        return Container(
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 10),
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            // color: AppColors.accentColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child:
              state is UpdateAvatarLoading
                  ? Center(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  )
                  : Image(
                    image: NetworkImage(currentUser.avatar!),
                    fit: BoxFit.cover,
                  ),
        );
      },
    );
  }
}
