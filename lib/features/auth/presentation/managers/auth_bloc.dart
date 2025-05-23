import 'package:bloc/bloc.dart';
import 'package:hessa/features/auth/data/models/forgot_password_request.dart';
import 'package:hessa/features/auth/data/models/forgot_password_response.dart';
import 'package:hessa/features/auth/data/models/login_request.dart';
import 'package:hessa/features/auth/data/models/login_response.dart';
import 'package:hessa/features/auth/data/models/register_request.dart';
import 'package:hessa/features/auth/data/models/register_response.dart';
import 'package:hessa/features/auth/data/models/verify_email_request.dart';
import 'package:hessa/features/auth/data/models/verify_email_response.dart';
import 'package:hessa/features/auth/data/repositories/auth_service.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService service;

  AuthBloc(this.service) : super(AuthInitial()) {
    on<RegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      final response = await service.register(request: event.request);
      response.fold(
        (failure) {
          emit(RegisterFailure(message: failure.message));
        },
        (data) {
          emit(RegisterSuccess(response: data));
        },
      );
    });

    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());
      final response = await service.login(request: event.request);
      response.fold(
        (failure) {
          print(failure);
          emit(LoginFailure(message: failure.message));
        },
        (data) {
          print(data);

          emit(LoginSuccess(response: data));
        },
      );
    });

    on<VerifyEmailEvent>((event, emit) async {
      emit(VerifyEmailLoading());
      final response = await service.verifyEmail(request: event.request);
      response.fold(
        (failure) {
          print(failure);
          emit(VerifyEmailFailure(message: failure.message));
        },
        (data) {
          print(data);
          emit(VerifyEmailSuccess(response: data));
        },
      );
    });

    on<LogoutEvent>((event, emit) async {
      emit(LogoutLoading());
      service.logout();
      emit(LogoutSuccess());
    });
  }
}
