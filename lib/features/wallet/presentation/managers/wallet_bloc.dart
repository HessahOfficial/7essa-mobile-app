import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hessa/features/wallet/data/models/create_payment_request.dart';
import 'package:hessa/features/wallet/data/models/create_payment_response.dart';
import 'package:hessa/features/wallet/data/models/get_payment_history_request.dart';
import 'package:hessa/features/wallet/data/models/get_payment_history_response.dart';
import 'package:hessa/features/wallet/data/models/payment_model.dart';
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

  List<PaymentModel> payments = [];

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

    on<CreatePaymentEvent>((event, emit) async {
      emit(CreatePaymnetLoading());
      final response = await service.createPayment(request: event.request);
      response.fold(
        (failure) {
          emit(CreatePaymentFailure(message: failure.message));
        },
        (data) {
          hidden = false;
          emit(CreatePaymentSuccess(response: data));
        },
      );
    });

    on<GetPaymentHistoryEvent>((event, emit) async {
      emit(GetPaymentHistoryLoading());
      final response = await service.getPaymentHistory(request: event.request);
      response.fold(
        (failure) {
          emit(GetPaymentHistoryFailure(message: failure.message));
        },
        (data) {
          hidden = false;
          payments = data.payments;
          emit(GetPaymentHistorySuccess(response: data));
        },
      );
    });

    on<GetDepositHistoryEvent>((event, emit) async {
      emit(GetDepositHistoryLoading());
      final response = await service.getDepositHistory(request: event.request);
      response.fold(
        (failure) {
          emit(GetDepositHistoryFailure(message: failure.message));
        },
        (data) {
          hidden = false;
          payments = data.payments;
          emit(GetDepositHistorySuccess(response: data));
        },
      );
    });

    on<GetWithdrawHistoryEvent>((event, emit) async {
      emit(GetWithdrawHistoryLoading());
      final response = await service.getWithdrawHistory(request: event.request);
      response.fold(
        (failure) {
          emit(GetWithdrawHistoryFailure(message: failure.message));
        },
        (data) {
          hidden = false;
          payments = data.payments;
          emit(GetWithdrawHistorySuccess(response: data));
        },
      );
    });
  }
}
