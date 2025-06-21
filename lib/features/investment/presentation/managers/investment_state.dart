part of 'investment_bloc.dart';

@immutable
abstract class InvestmentState {}

class InvestmentInitial extends InvestmentState {}

class CheckInvestor extends InvestmentState {}

class DisplayInvestment extends InvestmentState {}

class GetAllInvestmentsLoading extends InvestmentState {}

class GetAllInvestmentsSuccess extends InvestmentState {
  final GetAllInvestmentsResponse response;

  GetAllInvestmentsSuccess({required this.response});
}

class GetAllInvestmentsFailure extends InvestmentState {
  final String message;

  GetAllInvestmentsFailure({required this.message});
}
