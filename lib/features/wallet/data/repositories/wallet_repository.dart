import 'package:dartz/dartz.dart';
import 'package:hessa/core/errors/failures.dart';
import 'package:hessa/features/wallet/data/models/create_payment_request.dart';
import 'package:hessa/features/wallet/data/models/create_payment_response.dart';
import 'package:hessa/features/wallet/data/models/get_payment_history_request.dart';
import 'package:hessa/features/wallet/data/models/get_payment_history_response.dart';
import 'package:hessa/features/wallet/data/models/show_balance_request.dart';
import 'package:hessa/features/wallet/data/models/show_balance_response.dart';

abstract class WalletRepository {
  Future<Either<Failure, ShowBalanceResponse>> showBalance({
    required ShowBalanceRequest request,
  });

  Future<Either<Failure, CreatePaymentResponse>> createPayment({
    required CreatePaymentRequest request,
  });

  Future<Either<Failure, GetPaymentHistoryResponse>> getPaymentHistory({
    required GetPaymentHistoryRequest request,
  });

  Future<Either<Failure, GetPaymentHistoryResponse>> getDepositHistory({
    required GetPaymentHistoryRequest request,
  });

  Future<Either<Failure, GetPaymentHistoryResponse>> getWithdrawHistory({
    required GetPaymentHistoryRequest request,
  });
}
