import 'package:dartz/dartz.dart';
import 'package:hessa/core/errors/failures.dart';
import 'package:hessa/features/contact/data/models/contact_us_request.dart';
import 'package:hessa/features/contact/data/models/contact_us_response.dart';

abstract class ContactRepository {
  Future<Either<Failure, ContactUsResponse>> contactUs({
    required ContactUsRequest request,
  });
}
