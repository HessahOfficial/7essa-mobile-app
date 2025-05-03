import 'package:dartz/dartz.dart';
import 'package:hessa/core/errors/failures.dart';
import 'package:hessa/features/auth/data/models/login_request.dart';
import 'package:hessa/features/auth/data/models/login_response.dart';
import 'package:hessa/features/auth/data/models/register_request.dart';
import 'package:hessa/features/auth/data/models/register_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, RegisterResponse>> register({
    required RegisterRequest request,
  });

  Future<Either<Failure, LoginResponse>> login({required LoginRequest request});
}
