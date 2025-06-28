import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hessa/core/errors/failures.dart';
import 'package:hessa/core/helpers/dio_helper.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/endpoints.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/investment/data/models/get_all_investments_request.dart';
import 'package:hessa/features/investment/data/models/get_all_investments_response.dart';
import 'package:hessa/features/investment/data/models/make_investment_request.dart';
import 'package:hessa/features/investment/data/models/make_investment_response.dart';
import 'package:hessa/features/investment/data/repositories/investment_repository.dart';

class InvestmentService extends InvestmentRepository {
  final DioHelper helper;

  InvestmentService({required this.helper});

  @override
  Future<Either<Failure, GetAllInvestmentsResponse>> getAllInvestment({
    required GetAllInvestmentsRequest request,
  }) async {
    try {
      final tokens = getIt.get<HiveHelper>().token;
      final options = helper.getDioOptions(token: tokens!.accessToken!);
      final data = await helper.get(
        endpoint: Endpoints.getAllUserInvestments,
        options: options,
        params: request.toJson(),
      );
      final response = GetAllInvestmentsResponse.fromJson(
        data["data"]["investments"],
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
  Future<Either<Failure, MakeInvestmentResponse>> makeInvestment({
    required MakeInvestmentRequest request,
  }) async {
    try {
      final tokens = getIt.get<HiveHelper>().token;
      final options = helper.getDioOptions(token: tokens!.accessToken!);
      await helper.post(
        endpoint: Endpoints.makeUserInvestment.replaceAll(
          ":propertyId",
          request.propertyId,
        ),
        options: options,
        body: request.toJson(),
      );
      return right(MakeInvestmentResponse());
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(exception: e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }
}
