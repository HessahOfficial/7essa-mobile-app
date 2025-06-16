import 'package:hessa/core/utils/type_aliases.dart';

class UpdateUserRequest {
  String? avatar;
  String? username;
  String? firstname;
  String? lastname;
  String? fullname;
  String? phoneNumber;

  UpdateUserRequest({
    this.avatar,
    this.firstname,
    this.lastname,
    this.fullname,
    this.username,
    this.phoneNumber,
  });

  Json toJson() {
    return {
      "avatar": avatar,
      "firstName": firstname,
      "lastName": lastname,
      "fullName": fullname,
      "username": username,
      "phoneNumber": phoneNumber,
    };
  }
}
