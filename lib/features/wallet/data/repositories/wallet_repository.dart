import 'package:dartz/dartz.dart';
import 'package:hessa/core/errors/failures.dart';
import 'package:hessa/features/wallet/data/models/show_balance_request.dart';
import 'package:hessa/features/wallet/data/models/show_balance_response.dart';

abstract class WalletRepository {
  Future<Either<Failure, ShowBalanceResponse>> showBalance({
    required ShowBalanceRequest request,
  });
}
