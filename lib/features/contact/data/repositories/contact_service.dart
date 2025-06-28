import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hessa/core/errors/failures.dart';
import 'package:hessa/core/helpers/dio_helper.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/endpoints.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/contact/data/models/contact_us_request.dart';
import 'package:hessa/features/contact/data/models/contact_us_response.dart';
import 'package:hessa/features/contact/data/repositories/contact_repository.dart';

class ContactService extends ContactRepository {
  final DioHelper helper;

  ContactService({required this.helper});

  @override
  Future<Either<Failure, ContactUsResponse>> contactUs({
    required ContactUsRequest request,
  }) async {
    try {
      final tokens = getIt.get<HiveHelper>().token;
      final options = helper.getDioOptions(token: tokens!.accessToken!);
      await helper.post(
        endpoint: Endpoints.contact,
        options: options,
        body: request.toJson(),
      );
      return right(ContactUsResponse());
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(exception: e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }
}
