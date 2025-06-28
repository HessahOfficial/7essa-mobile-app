part of 'wallet_bloc.dart';

@immutable
abstract class WalletEvent {}

class ShowBalanceEvent extends WalletEvent {
  final ShowBalanceRequest request;

  ShowBalanceEvent({required this.request});
}

class CreatePaymentEvent extends WalletEvent {
  final CreatePaymentRequest request;

  CreatePaymentEvent({required this.request});
}

class GetPaymentHistoryEvent extends WalletEvent {
  final GetPaymentHistoryRequest request;

  GetPaymentHistoryEvent({required this.request});
}

class GetDepositHistoryEvent extends WalletEvent {
  final GetPaymentHistoryRequest request;

  GetDepositHistoryEvent({required this.request});
}

class GetWithdrawHistoryEvent extends WalletEvent {
  final GetPaymentHistoryRequest request;

  GetWithdrawHistoryEvent({required this.request});
}
