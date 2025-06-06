import 'package:hessa/core/utils/type_aliases.dart';

class GetInfoResponse {
  String? username;
  String? email;
  String? avatar;

  GetInfoResponse.fromJson(Json json) {
    username = json["username"];
    email = json["email"];
    avatar = json["avatar"];
  }
}
