import 'package:hessa/core/utils/type_aliases.dart';

class VerifyEmailResponse {
  String? message;
  String? status;

  VerifyEmailResponse.fromJson(Json json) {
    message = json["message"];
    status = json["status"];
  }
}
