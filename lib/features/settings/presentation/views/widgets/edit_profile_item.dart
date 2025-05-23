import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/features/settings/presentation/managers/update_cubit.dart';
import 'package:hessa/generated/l10n.dart';

class EditProfileItem extends StatelessWidget {
  const EditProfileItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateCubit, UpdateState>(
      builder: (bccontext, state) {
        bool isUpdate = context.read<UpdateCubit>().isUpdate;

        return Row(
          spacing: 10,
          children: [
            Icon(Icons.edit, size: 30),
            Text(
              S.of(context).editProfile,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Spacer(),
            CustomButton(
              width: 100,
              height: 30,
              text: isUpdate ? S.of(context).save : S.of(context).edit,
              textColor: Colors.white,
              backgroundColor: isUpdate ? Colors.green : null,
              onPressed:
                  () => context.read<UpdateCubit>().updateDetails(
                    isUpdate: isUpdate ? false : true,
                  ),
            ),
          ],
        );
      },
    );
  }
}
