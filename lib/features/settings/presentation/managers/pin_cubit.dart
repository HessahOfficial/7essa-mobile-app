import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/settings/presentation/views/widgets/custom_pin_dialog.dart';
import 'package:hessa/generated/l10n.dart';

import 'package:meta/meta.dart';

part 'pin_state.dart';

class PinCubit extends Cubit<PinState> {
  PinCubit() : super(PinInitial());

  Future<void> changePin({
    required BuildContext context,
    required String pin,
  }) async {
    final storedPin = await getIt.get<HiveHelper>().getPin();
    if (storedPin == null) {
      getIt.get<HiveHelper>().storePin(pin: pin);
      context.pop();
      emit(PinSuccess());
    } else {
      if (storedPin == pin) {
        context.pop();
        emit(PinFailure(message: S.of(context).pinError));
      } else {
        getIt.get<HiveHelper>().storePin(pin: pin);
        context.pop();
        emit(PinSuccess());
      }
    }
  }

  void showPinDialog({required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CustomPinDialog(),
    );
  }
}
