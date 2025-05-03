import 'package:hessa/core/utils/type_aliases.dart';

class RegisterResponse {
  String? message;
  String? accessToken;
  String? refreshToken;

  RegisterResponse.fromJson(Json json) {
    message = json["message"];
    accessToken = json["accessToken"];
    refreshToken = json["refreshToken"];
  }
}
