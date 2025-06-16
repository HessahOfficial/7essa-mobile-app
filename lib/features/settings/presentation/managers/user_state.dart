part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

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

class ActiveUpdate extends UserState {}

class UpdateUserLoading extends UserState {}

class UpdateUserSuccess extends UserState {
  final UpdateUserResponse response;

  UpdateUserSuccess({required this.response});
}

class UpdateUserFailure extends UserState {
  final String message;

  UpdateUserFailure({required this.message});
}

class UpdateAvatarLoading extends UserState {}

class UpdateAvatarSuccess extends UserState {
  final UpdateUserResponse response;

  UpdateAvatarSuccess({required this.response});
}

class UpdateAvatarFailure extends UserState {
  final String message;

  UpdateAvatarFailure({required this.message});
}
