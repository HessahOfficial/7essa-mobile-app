part of 'wallet_bloc.dart';

@immutable
abstract class WalletEvent {}

class ShowBalanceEvent extends WalletEvent {
  final ShowBalanceRequest request;

  ShowBalanceEvent({required this.request});
}
