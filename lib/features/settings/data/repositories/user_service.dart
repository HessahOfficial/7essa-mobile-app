import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:hessa/core/errors/failures.dart';
import 'package:hessa/core/helpers/dio_helper.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/endpoints.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/home/data/models/get_all_partners_request.dart';
import 'package:hessa/features/home/data/models/get_all_partners_response.dart';
import 'package:hessa/features/settings/data/models/become_investor_request.dart';
import 'package:hessa/features/settings/data/models/become_investor_response.dart';
import 'package:hessa/features/settings/data/models/change_pin_request.dart';
import 'package:hessa/features/settings/data/models/change_pin_response.dart';
import 'package:hessa/features/settings/data/models/update_user_request.dart';
import 'package:hessa/features/settings/data/models/update_user_response.dart';
import 'package:hessa/features/settings/data/repositories/user_repository.dart';
import 'package:path/path.dart';

class UserService implements UserRepository {
  final DioHelper helper;

  UserService({required this.helper});

  @override
  Future<Either<Failure, ChangePinResponse>> changeUserPin({
    required ChangePinRequest request,
  }) async {
    try {
      final tokens = getIt.get<HiveHelper>().token;
      final options = helper.getDioOptions(token: tokens!.accessToken!);
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
      final options = helper.getDioOptions(token: tokens!.accessToken!);
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

  @override
  Future<Either<Failure, UpdateUserResponse>> updateUser({
    required UpdateUserRequest request,
  }) async {
    try {
      final tokens = getIt.get<HiveHelper>().token;
      final options = helper.getDioOptions(token: tokens!.accessToken!);
      final currentUser = getIt.get<HiveHelper>().currentUser;
      final data = await helper.patch(
        endpoint: Endpoints.userInfo.replaceAll(":userId", currentUser!.id!),
        options: options,
        body: request.toJson(),
      );
      final response = UpdateUserResponse.fromJson(data["data"]["user"]);
      currentUser.username = response.username ?? currentUser.username;
      currentUser.firstName = response.firstname ?? currentUser.firstName;
      currentUser.lastName = response.lastname ?? currentUser.lastName;
      currentUser.fullName = response.fullname ?? currentUser.fullName;
      currentUser.phoneNumber = response.phoneNumber ?? currentUser.phoneNumber;
      currentUser.avatar = response.avatar ?? currentUser.avatar;
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
  Future<Either<Failure, GetAllPartnersResponse>> getPartners({
    required GetAllPartnersRequest request,
  }) async {
    try {
      final tokens = getIt.get<HiveHelper>().token;
      final options = helper.getDioOptions(token: tokens!.accessToken!);
      final data = await helper.get(
        endpoint: Endpoints.getAllPartners,
        options: options,
      );
      final response = GetAllPartnersResponse.fromJson(
        data["data"]["partners"],
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
