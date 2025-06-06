import 'package:dartz/dartz.dart';
import 'package:hessa/core/errors/failures.dart';
import 'package:hessa/features/settings/data/models/get_info_request.dart';
import 'package:hessa/features/settings/data/models/get_info_response.dart';

abstract class UserRepository {
  Future<Either<Failure, GetInfoResponse>> getUserInfo({
    required GetInfoRequest request,
  });
}
