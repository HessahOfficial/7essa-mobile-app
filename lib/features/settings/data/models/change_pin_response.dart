import 'package:hessa/core/utils/type_aliases.dart';

class ChangePinResponse {
  String? message;

  ChangePinResponse.fromJson(Json json) {
    message = json["message"];
  }
}
