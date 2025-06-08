import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:hessa/core/errors/failures.dart';
import 'package:hessa/core/helpers/dio_helper.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/endpoints.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/settings/data/models/become_investor_request.dart';
import 'package:hessa/features/settings/data/models/become_investor_response.dart';
import 'package:hessa/features/settings/data/models/change_pin_request.dart';
import 'package:hessa/features/settings/data/models/change_pin_response.dart';
import 'package:hessa/features/settings/data/models/get_info_request.dart';
import 'package:hessa/features/settings/data/models/get_info_response.dart';
import 'package:hessa/features/settings/data/repositories/user_repository.dart';

class UserService implements UserRepository {
  final DioHelper helper;

  UserService({required this.helper});

  @override
  Future<Either<Failure, GetInfoResponse>> getUserInfo({
    required GetInfoRequest request,
  }) async {
    try {
      final tokens = getIt.get<HiveHelper>().token;
      final options = getIt.get<DioHelper>().getDioOptions(
        accessToken: tokens!.accessToken!,
      );
      final data = await helper.get(
        endpoint: Endpoints.getUserInfo.replaceAll(":userId", request.userId),
        options: options,
      );
      final response = GetInfoResponse.fromJson(data["data"]["user"]);
      final currentUser = getIt.get<HiveHelper>().currentUser;
      currentUser!.email = response.email;
      currentUser.username = response.username;
      currentUser.avatar = response.avatar;
      await getIt.get<HiveHelper>().storeCurrentUser(
        tokens: tokens,
        user: currentUser,
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
  Future<Either<Failure, ChangePinResponse>> changeUserPin({
    required ChangePinRequest request,
  }) async {
    try {
      final tokens = getIt.get<HiveHelper>().token;
      final options = getIt.get<DioHelper>().getDioOptions(
        accessToken: tokens!.accessToken!,
      );
      final currentUser = getIt.get<HiveHelper>().currentUser;
      final data = await helper.post(
        endpoint: Endpoints.changeUserPin.replaceAll(
          ":userId",
          currentUser!.id!,
        ),
        options: options,
        body: request.toJson(),
      );
      final response = ChangePinResponse.fromJson(data);
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(exception: e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BecomeInvestorResponse>> becomeInvestor({
    required BecomeInvestorRequest request,
  }) async {
    try {
      final tokens = getIt.get<HiveHelper>().token;
      final options = getIt.get<DioHelper>().getDioOptions(
        accessToken: tokens!.accessToken!,
      );
      final currentUser = getIt.get<HiveHelper>().currentUser;
      final data = await helper.post(
        endpoint: Endpoints.becomeInvestorUser.replaceAll(
          ":userId",
          currentUser!.id!,
        ),
        options: options,
        body: request.toJson(),
      );
      final response = BecomeInvestorResponse.fromJson(data["data"]["user"]);
      currentUser.email = response.email;
      currentUser.username = response.username;
      currentUser.isInvestor = response.isInvestor;
      currentUser.nationalId = response.nationalId;
      currentUser.avatar = response.avatar;
      currentUser.phoneNumber = response.phoneNumber;
      await getIt.get<HiveHelper>().storeCurrentUser(
        tokens: tokens,
        user: currentUser,
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
