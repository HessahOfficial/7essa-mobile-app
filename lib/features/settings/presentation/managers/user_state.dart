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
