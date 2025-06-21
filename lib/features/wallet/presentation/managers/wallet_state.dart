part of 'wallet_bloc.dart';

@immutable
abstract class WalletState {}

class WalletInitial extends WalletState {}

class InvisibleBalance extends WalletState {}

class SelectPaymentOption extends WalletState {}

class ShowBalanceLoading extends WalletState {}

class ShowBalanceSuccess extends WalletState {
  final ShowBalanceResponse response;

  ShowBalanceSuccess({required this.response});
}

class ShowBalanceFaliure extends WalletState {
  final String message;

  ShowBalanceFaliure({required this.message});
}
