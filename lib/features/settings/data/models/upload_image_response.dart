import 'package:hessa/core/utils/type_aliases.dart';

class UploadImageResponse {
  String? image_url;

  UploadImageResponse.fromJson(Json json) {
    image_url = json["secure_url"];
  }
}
