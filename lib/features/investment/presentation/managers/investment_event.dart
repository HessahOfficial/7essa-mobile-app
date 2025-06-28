part of 'investment_bloc.dart';

@immutable
abstract class InvestmentEvent {}

class GetAllInvestmentsEvent extends InvestmentEvent {
  final GetAllInvestmentsRequest request;

  GetAllInvestmentsEvent({required this.request});
}

class MakeInvestmentEvent extends InvestmentEvent {
  final MakeInvestmentRequest request;

  MakeInvestmentEvent({required this.request});
}
