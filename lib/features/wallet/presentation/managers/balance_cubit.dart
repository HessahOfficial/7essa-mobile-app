import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/wallet/presentation/views/widgets/custom_password_dialog.dart';
import 'package:meta/meta.dart';

part 'balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {
  BalanceCubit() : super(BalanceInitial());

  bool hide = true;

  void showBalance(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CustomPasswordDialog(),
    );
  }

  void validatePassword({
    required String password,
    required BuildContext context,
  }) {
    final pinCode = getIt.get<HiveHelper>().currentUser!.pin!;
    if (password == pinCode.toString()) {
      hide = false;
      Navigator.of(context).pop();
      emit(BalanceVisible());
    } else {
      Navigator.of(context).pop();
      emit(BalanceFailure(message: "Incorrect PIN code!"));
    }
  }

  void balanceVisibility() {
    hide = true;
    emit(BalanceInvisible());
  }
}
