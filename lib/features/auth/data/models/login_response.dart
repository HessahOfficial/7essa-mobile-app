import 'package:hessa/core/utils/type_aliases.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';

class LoginResponse {
  UserModel? user;
  String? accessToken;
  String? refreshToken;

  LoginResponse.fromJson(Json json) {
    user = UserModel.fromJson(json["user"]);
    accessToken = json["accessToken"];
    refreshToken = json["refreshToken"];
  }
}
