import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/features/settings/presentation/managers/pin_cubit.dart';
import 'package:hessa/generated/l10n.dart';

class ChangePinItem extends StatelessWidget {
  final BuildContext screenContext;

  const ChangePinItem({super.key, required this.screenContext});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Icon(Icons.wallet, size: 30),
        Text(
          S.of(context).changePin,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        Spacer(),
        CustomButton(
          width: 100,
          height: 30,
          text: S.of(context).change,
          textColor: Colors.white,
          onPressed:
              () => context.read<PinCubit>().showPinDialog(
                context: screenContext,
              ),
        ),
      ],
    );
  }
}
