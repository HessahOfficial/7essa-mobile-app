part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {
  final RegisterResponse response;

  RegisterSuccess({required this.response});
}

class RegisterFailure extends AuthState {
  final String message;

  RegisterFailure({required this.message});
}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final LoginResponse response;

  LoginSuccess({required this.response});
}

class LoginFailure extends AuthState {
  final String message;

  LoginFailure({required this.message});
}

class ForgotPasswordLoading extends AuthState {}

class ForgotPasswordSuccess extends AuthState {
  final ForgotPasswordResponse response;

  ForgotPasswordSuccess({required this.response});
}

class ForgotPasswordFailure extends AuthState {
  final String message;

  ForgotPasswordFailure({required this.message});
}
