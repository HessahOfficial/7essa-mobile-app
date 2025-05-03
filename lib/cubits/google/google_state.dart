part of 'google_cubit.dart';

@immutable
abstract class GoogleState {}

class GoogleInitial extends GoogleState {}

class GoogleLoading extends GoogleState {}

class GoogleSuccess extends GoogleState {
  final User user;

  GoogleSuccess({required this.user});
}

class AuthLoading extends GoogleState {}

class AuthSuccess extends GoogleState {}

class GoogleFailure extends GoogleState {
  final String message;

  GoogleFailure({required this.message});
}
