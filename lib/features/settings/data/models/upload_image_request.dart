import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hessa/core/utils/type_aliases.dart';

class UploadImageRequest {
  final File imageFile;

  UploadImageRequest({required this.imageFile});

  Future<FormData> toJson() async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imageFile.path),
      'upload_preset': "hessah",
    });

    return formData;
  }
}
