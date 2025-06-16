import 'package:hessa/core/utils/type_aliases.dart';

class UpdateUserResponse {
  String? avatar;
  String? username;
  String? firstname;
  String? lastname;
  String? fullname;
  String? phoneNumber;

  UpdateUserResponse.fromJson(Json json) {
    avatar = json["avatar"];
    firstname = json["firstName"];
    lastname = json["lastName"];
    fullname = json["fullName"];
    username = json["username"];
    phoneNumber = json["phoneNumber"];
  }
}
