part of 'investment_bloc.dart';

@immutable
abstract class InvestmentEvent {}

class GetAllInvestmentsEvent extends InvestmentEvent {
  final GetAllInvestmentsRequest request;

  GetAllInvestmentsEvent({required this.request});
}
