part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class RegisterEvent extends AuthEvent {
  final RegisterRequest request;

  RegisterEvent({required this.request});
}

class LoginEvent extends AuthEvent {
  final LoginRequest request;

  LoginEvent({required this.request});
}

class ForgotPasswordEvent extends AuthEvent {
  final ForgotPasswordRequest request;

  ForgotPasswordEvent({required this.request});
}

class VerifyEmailEvent extends AuthEvent {
  final VerifyEmailRequest request;

  VerifyEmailEvent({required this.request});
}

class LogoutEvent extends AuthEvent {}
