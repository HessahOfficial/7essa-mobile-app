import 'package:hessa/core/utils/type_aliases.dart';

class LoginResponse {
  String? message;
  String? accessToken;
  String? refreshToken;

  LoginResponse.fromJson(Json json) {
    message = json["message"];
    accessToken = json["accessToken"];
    refreshToken = json["refreshToken"];
  }
}
