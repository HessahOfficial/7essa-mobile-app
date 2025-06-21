import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hessa/features/wallet/data/models/show_balance_request.dart';
import 'package:hessa/features/wallet/data/models/show_balance_response.dart';
import 'package:hessa/features/wallet/data/repositories/wallet_service.dart';
import 'package:hessa/features/wallet/presentation/views/widgets/custom_password_dialog.dart';
import 'package:hessa/features/wallet/presentation/views/widgets/custom_payment_dialog.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletService service;

  bool hidden = true;

  int selectedPaymentOption = 0;
  String selectedPaymentMethod = "instaPay";

  void setSelectedPaymentOption(int selectedOptionIndex) {
    selectedPaymentOption = selectedOptionIndex;
    switch (selectedOptionIndex) {
      case 0:
        selectedPaymentMethod = "instapay";
        break;
      case 1:
        selectedPaymentMethod = "VodafoneCash";
        break;
      case 2:
        selectedPaymentMethod = "bankTransfer";
        break;
    }

    emit(SelectPaymentOption());
  }

  void showDepositDialog(BuildContext screenContext) {
    showModalBottomSheet(
      context: screenContext,
      backgroundColor: Theme.of(screenContext).scaffoldBackgroundColor,
      builder: (context) => CustomPaymentDialog(screenContext: screenContext),
    );
  }

  void showBalance(BuildContext context) {
    if (!hidden) {
      hidden = true;
      emit(InvisibleBalance());
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CustomPasswordDialog(),
    );
  }

  WalletBloc({required this.service}) : super(WalletInitial()) {
    on<ShowBalanceEvent>((event, emit) async {
      emit(ShowBalanceLoading());
      final response = await service.showBalance(request: event.request);
      response.fold(
        (failure) {
          emit(ShowBalanceFaliure(message: failure.message));
        },
        (data) {
          hidden = false;
          emit(ShowBalanceSuccess(response: data));
        },
      );
    });
  }
}
