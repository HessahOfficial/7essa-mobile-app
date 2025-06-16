import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';

import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/features/settings/presentation/managers/user_bloc.dart';
import 'package:hessa/generated/l10n.dart';

class EditProfileItem extends StatelessWidget {
  final void Function()? onSwitch;

  const EditProfileItem({super.key, this.onSwitch});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (bccontext, state) {
        bool isUpdate = context.read<UserBloc>().isUpdate;
        bool isDark = getIt.get<HiveHelper>().isDark ?? false;

        return Row(
          spacing: 10,
          children: [
            Icon(Icons.edit, size: 30),
            Text(
              S.of(context).editProfile,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Spacer(),
            state is UpdateUserLoading
                ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CircularProgressIndicator(
                    color: isDark ? Colors.white : Colors.black,
                  ),
                )
                : CustomButton(
                  width: 100,
                  height: 30,
                  text: isUpdate ? S.of(context).save : S.of(context).edit,
                  textColor: Colors.white,
                  backgroundColor: isUpdate ? Colors.green : null,
                  onPressed: onSwitch ?? () {},
                ),
          ],
        );
      },
    );
  }
}
