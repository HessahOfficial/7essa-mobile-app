part of 'google_cubit.dart';

@immutable
abstract class GoogleState {}

class GoogleInitial extends GoogleState {}

class GoogleSignInLoading extends GoogleState {}

class GoogleSignInSuccess extends GoogleState {
  final User user;

  GoogleSignInSuccess({required this.user});
}

class GoogleSignInFailure extends GoogleState {
  final String message;

  GoogleSignInFailure({required this.message});
}

class GoogleSignOutLoading extends GoogleState {}

class GoogleSignOutSuccess extends GoogleState {}

class GoogleSignOutFailure extends GoogleState {
  final String message;

  GoogleSignOutFailure({required this.message});
}
