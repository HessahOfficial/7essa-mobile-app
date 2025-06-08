part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserInfoLoading extends UserState {}

class UserInfoSuccess extends UserState {
  final GetInfoResponse response;

  UserInfoSuccess({required this.response});
}

class UserInfoFailure extends UserState {
  final String message;

  UserInfoFailure({required this.message});
}

class ChangePinLoading extends UserState {}

class ChangePinSuccess extends UserState {
  final ChangePinResponse response;

  ChangePinSuccess({required this.response});
}

class ChangePinFailure extends UserState {
  final String message;

  ChangePinFailure({required this.message});
}

class BecomeInvestorLoading extends UserState {}

class BecomeInvestorSuccess extends UserState {
  final BecomeInvestorResponse response;

  BecomeInvestorSuccess({required this.response});
}

class BecomeInvestorFailure extends UserState {
  final String message;

  BecomeInvestorFailure({required this.message});
}
