import 'package:hessa/core/utils/type_aliases.dart';

class ForgotPasswordResponse {
  String? status;

  ForgotPasswordResponse.fromJson(Json json) {
    status = json["status"];
  }
}
