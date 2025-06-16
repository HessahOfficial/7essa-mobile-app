import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hessa/core/errors/failures.dart';
import 'package:hessa/core/helpers/dio_helper.dart';
import 'package:hessa/features/settings/data/models/upload_image_request.dart';
import 'package:hessa/features/settings/data/models/upload_image_response.dart';
import 'package:hessa/features/settings/data/repositories/cloudinary_repository.dart';

class CloudinaryService extends CloudinaryRepository {
  final DioHelper helper;

  CloudinaryService({required this.helper});

  @override
  Future<Either<Failure, UploadImageResponse>> uploadImage({
    required UploadImageRequest request,
  }) async {
    try {
      final body = await request.toJson();
      final data = await helper.postFormData(body: body);
      final response = UploadImageResponse.fromJson(data);
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(exception: e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }
}
