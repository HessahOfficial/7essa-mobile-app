part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class ChangePinEvent extends UserEvent {
  final ChangePinRequest request;

  ChangePinEvent({required this.request});
}

class BecomeInvestorEvent extends UserEvent {
  final BecomeInvestorRequest request;

  BecomeInvestorEvent({required this.request});
}

class UpdateUserEvent extends UserEvent {
  final UpdateUserRequest request;

  UpdateUserEvent({required this.request});
}

class UpdateAvatarEvent extends UserEvent {
  final UpdateUserRequest request;

  UpdateAvatarEvent({required this.request});
}
