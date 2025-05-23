import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/settings/presentation/views/widgets/custom_info_popup.dart';
import 'package:hessa/generated/l10n.dart';
import 'package:meta/meta.dart';

part 'investor_state.dart';

class InvestorCubit extends Cubit<InvestorState> {
  InvestorCubit() : super(InvestorInitial());

  bool isInvestor = getIt.get<HiveHelper>().currentUser!.isInvestor ?? false;

  Future<void> becomeInvestor({required BuildContext context}) async {
    if (!isInvestor) {
      showDialog(
        context: context,
        builder:
            (context) => CustomInfoPopup(
              icon: Icons.info,
              message: S.of(context).becomeInvestorPopup,
            ),
      );
      emit(InvestorSuccess());
    }
  }
}
