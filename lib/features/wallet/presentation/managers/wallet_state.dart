part of 'wallet_bloc.dart';

@immutable
abstract class WalletState {}

class WalletInitial extends WalletState {}

class InvisibleBalance extends WalletState {}

class SelectPaymentOption extends WalletState {}

class ChangeFilter extends WalletState {}

class ShowBalanceLoading extends WalletState {}

class ShowBalanceSuccess extends WalletState {
  final ShowBalanceResponse response;

  ShowBalanceSuccess({required this.response});
}

class ShowBalanceFaliure extends WalletState {
  final String message;

  ShowBalanceFaliure({required this.message});
}

class CreatePaymnetLoading extends WalletState {}

class CreatePaymentSuccess extends WalletState {
  final CreatePaymentResponse response;

  CreatePaymentSuccess({required this.response});
}

class CreatePaymentFailure extends WalletState {
  final String message;

  CreatePaymentFailure({required this.message});
}

class GetPaymentHistoryLoading extends WalletState {}

class GetPaymentHistorySuccess extends WalletState {
  final GetPaymentHistoryResponse response;

  GetPaymentHistorySuccess({required this.response});
}

class GetPaymentHistoryFailure extends WalletState {
  final String message;

  GetPaymentHistoryFailure({required this.message});
}

class GetDepositHistoryLoading extends WalletState {}

class GetDepositHistorySuccess extends WalletState {
  final GetPaymentHistoryResponse response;

  GetDepositHistorySuccess({required this.response});
}

class GetDepositHistoryFailure extends WalletState {
  final String message;

  GetDepositHistoryFailure({required this.message});
}

class GetWithdrawHistoryLoading extends WalletState {}

class GetWithdrawHistorySuccess extends WalletState {
  final GetPaymentHistoryResponse response;

  GetWithdrawHistorySuccess({required this.response});
}

class GetWithdrawHistoryFailure extends WalletState {
  final String message;

  GetWithdrawHistoryFailure({required this.message});
}
