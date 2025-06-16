import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hessa/core/errors/failures.dart';
import 'package:hessa/core/helpers/dio_helper.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/endpoints.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/wallet/data/models/show_balance_request.dart';
import 'package:hessa/features/wallet/data/models/show_balance_response.dart';
import 'package:hessa/features/wallet/data/repositories/wallet_repository.dart';

class WalletService implements WalletRepository {
  final DioHelper helper;

  WalletService({required this.helper});

  @override
  Future<Either<Failure, ShowBalanceResponse>> showBalance({
    required ShowBalanceRequest request,
  }) async {
    try {
      final tokens = getIt.get<HiveHelper>().token;
      final options = helper.getDioOptions(token: tokens!.accessToken!);
      final currentUser = getIt.get<HiveHelper>().currentUser;
      final data = await helper.post(
        endpoint: Endpoints.showBalance.replaceAll(":userId", currentUser!.id!),
        body: request.toJson(),
        options: options,
      );
      final response = ShowBalanceResponse.fromJson(data["data"]);
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(exception: e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }
}
