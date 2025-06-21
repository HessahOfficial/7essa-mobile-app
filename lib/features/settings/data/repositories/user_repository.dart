import 'package:dartz/dartz.dart';
import 'package:hessa/core/errors/failures.dart';
import 'package:hessa/features/home/data/models/get_all_partners_request.dart';
import 'package:hessa/features/home/data/models/get_all_partners_response.dart';
import 'package:hessa/features/settings/data/models/become_investor_request.dart';
import 'package:hessa/features/settings/data/models/become_investor_response.dart';
import 'package:hessa/features/settings/data/models/change_pin_request.dart';
import 'package:hessa/features/settings/data/models/change_pin_response.dart';
import 'package:hessa/features/settings/data/models/update_user_request.dart';
import 'package:hessa/features/settings/data/models/update_user_response.dart';

abstract class UserRepository {
  Future<Either<Failure, ChangePinResponse>> changeUserPin({
    required ChangePinRequest request,
  });

  Future<Either<Failure, BecomeInvestorResponse>> becomeInvestor({
    required BecomeInvestorRequest request,
  });

  Future<Either<Failure, UpdateUserResponse>> updateUser({
    required UpdateUserRequest request,
  });

  Future<Either<Failure, GetAllPartnersResponse>> getPartners({
    required GetAllPartnersRequest request,
  });
}
