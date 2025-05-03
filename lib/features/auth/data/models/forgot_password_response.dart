import 'package:hessa/core/utils/type_aliases.dart';

class ForgotPasswordResponse {
  String? message;

  ForgotPasswordResponse.fromJson(Json json) {
    message = json["message"];
  }
}
