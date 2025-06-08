part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class GetInfoEvent extends UserEvent {
  final GetInfoRequest request;

  GetInfoEvent({required this.request});
}

class ChangePinEvent extends UserEvent {
  final ChangePinRequest request;

  ChangePinEvent({required this.request});
}

class BecomeInvestorEvent extends UserEvent {
  final BecomeInvestorRequest request;

  BecomeInvestorEvent({required this.request});
}
