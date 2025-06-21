import 'package:dartz/dartz.dart';
import 'package:hessa/core/errors/failures.dart';
import 'package:hessa/features/investment/data/models/get_all_investments_request.dart';
import 'package:hessa/features/investment/data/models/get_all_investments_response.dart';

abstract class InvestmentRepository {
  Future<Either<Failure, GetAllInvestmentsResponse>> getAllInvestment({
    required GetAllInvestmentsRequest request,
  });
}
