import 'package:dartz/dartz.dart';
import 'package:hessa/core/errors/failures.dart';
import 'package:hessa/features/settings/data/models/upload_image_request.dart';
import 'package:hessa/features/settings/data/models/upload_image_response.dart';

abstract class CloudinaryRepository {
  Future<Either<Failure, UploadImageResponse>> uploadImage({
    required UploadImageRequest request,
  });
}
