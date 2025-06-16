import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:hessa/core/errors/failures.dart';
import 'package:hessa/core/helpers/dio_helper.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/endpoints.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/auth/data/models/forgot_password_request.dart';
import 'package:hessa/features/auth/data/models/forgot_password_response.dart';
import 'package:hessa/features/auth/data/models/login_request.dart';
import 'package:hessa/features/auth/data/models/login_response.dart';
import 'package:hessa/features/auth/data/models/refresh_token_request.dart';
import 'package:hessa/features/auth/data/models/refresh_token_response.dart';
import 'package:hessa/features/auth/data/models/register_request.dart';
import 'package:hessa/features/auth/data/models/register_response.dart';
import 'package:hessa/features/auth/data/models/token_model.dart';
import 'package:hessa/features/auth/data/models/verify_email_request.dart';
import 'package:hessa/features/auth/data/models/verify_email_response.dart';
import 'package:hessa/features/auth/data/repositories/auth_repository.dart';

class AuthService extends AuthRepository {
  final DioHelper helper;

  AuthService({required this.helper});

  @override
  Future<Either<Failure, RegisterResponse>> register({
    required RegisterRequest request,
  }) async {
    try {
      final data = await helper.post(
        endpoint: Endpoints.signUp,
        body: request.toJson(),
      );
      final response = RegisterResponse.fromJson(data["data"]);
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(exception: e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, VerifyEmailResponse>> verifyEmail({
    required VerifyEmailRequest request,
  }) async {
    try {
      final data = await helper.post(
        endpoint: Endpoints.verifyEmail,
        body: request.toJson(),
      );
      final response = VerifyEmailResponse.fromJson(data);
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(exception: e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginResponse>> login({
    required LoginRequest request,
  }) async {
    try {
      final data = await helper.post(
        endpoint: Endpoints.signIn,
        body: request.toJson(),
      );
      final response = LoginResponse.fromJson(data["data"]);
      await getIt.get<HiveHelper>().storeCurrentUser(
        user: response.user!,
        tokens: TokenModel.fromJson(data["data"]),
      );
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(exception: e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  void logout() {
    getIt.get<HiveHelper>().storeCurrentUser(user: null, tokens: null);
    getIt.get<HiveHelper>().storeIsGoogleAuth(isGoogleAuth: null);
  }

  @override
  Future<Either<Failure, ForgotPasswordResponse>> forgotPassword({
    required ForgotPasswordRequest request,
  }) async {
    try {
      final data = await helper.post(
        endpoint: Endpoints.forgotPassword,
        body: request.toJson(),
      );
      final response = ForgotPasswordResponse.fromJson(data);
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(exception: e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, RefreshTokenResponse>> refreshUserToken({
    required RefreshTokenRequest request,
  }) async {
    try {
      final options = helper.getDioOptions(token: request.refreshToken);
      final data = await helper.get(
        endpoint: Endpoints.refreshUserToken,
        options: options,
      );
      final response = RefreshTokenResponse.fromJson(data["data"]);
      final currentUser = getIt.get<HiveHelper>().currentUser;
      currentUser!.username = response.user!.username;
      currentUser!.firstName = response.user!.firstName;
      currentUser!.lastName = response.user!.lastName;
      currentUser!.fullName = response.user!.fullName;
      currentUser!.phoneNumber = response.user!.phoneNumber;
      currentUser!.email = response.user!.email;
      currentUser!.isInvestor = response.user!.isInvestor;
      currentUser!.id = response.user!.id;
      await getIt.get<HiveHelper>().storeCurrentUser(
        user: currentUser,
        tokens: response.tokens,
      );
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(exception: e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }
}
