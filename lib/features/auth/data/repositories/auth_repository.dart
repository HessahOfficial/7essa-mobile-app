import 'package:dartz/dartz.dart';
import 'package:hessa/core/errors/failures.dart';
import 'package:hessa/features/auth/data/models/forgot_password_request.dart';
import 'package:hessa/features/auth/data/models/forgot_password_response.dart';
import 'package:hessa/features/auth/data/models/login_request.dart';
import 'package:hessa/features/auth/data/models/login_response.dart';
import 'package:hessa/features/auth/data/models/refresh_token_request.dart';
import 'package:hessa/features/auth/data/models/refresh_token_response.dart';
import 'package:hessa/features/auth/data/models/register_request.dart';
import 'package:hessa/features/auth/data/models/register_response.dart';
import 'package:hessa/features/auth/data/models/verify_email_request.dart';
import 'package:hessa/features/auth/data/models/verify_email_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, RegisterResponse>> register({
    required RegisterRequest request,
  });

  Future<Either<Failure, VerifyEmailResponse>> verifyEmail({
    required VerifyEmailRequest request,
  });

  Future<Either<Failure, LoginResponse>> login({required LoginRequest request});

  Future<Either<Failure, ForgotPasswordResponse>> forgotPassword({
    required ForgotPasswordRequest request,
  });

  Future<Either<Failure, RefreshTokenResponse>> refreshUserToken({
    required RefreshTokenRequest request,
  });

  void logout();
}
