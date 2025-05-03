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
import 'package:hessa/features/auth/data/models/register_request.dart';
import 'package:hessa/features/auth/data/models/register_response.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';
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
      final currentUser = UserModel(
        accessToken: response.accessToken!,
        refreshToken: response.refreshToken!,
        emailAddress: request.email,
        phoneNumber: request.phoneNumber,
        name: request.name,
      );
      print(currentUser);
      await getIt.get<HiveHelper>().storeCurrentUser(user: currentUser);
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(exception: e));
      }
      return left(ServerFailure(message: e.toString()));
    }
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
      final response = ForgotPasswordResponse.fromJson(data["data"]);
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(exception: e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }

  // FIXME: can't receive the response.
  @override
  Future<Either<Failure, LoginResponse>> login({
    required LoginRequest request,
  }) async {
    try {
      print("=============Before Service================");
      final data = await helper.post(
        endpoint: Endpoints.signIn,
        body: request.toJson(),
      );
      print("==============After Service================");
      final response = LoginResponse.fromJson(data["data"]);
      return right(response);
    } catch (e) {
      print(e);
      if (e is DioException) {
        return left(ServerFailure.fromDioException(exception: e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }
}
