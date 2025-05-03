part of 'balance_cubit.dart';

@immutable
abstract class BalanceState {}

class BalanceInitial extends BalanceState {}

class BalanceVisible extends BalanceState {}

class BalanceInvisible extends BalanceState {}

class BalanceFailure extends BalanceState {
  final String message;

  BalanceFailure({required this.message});
}
