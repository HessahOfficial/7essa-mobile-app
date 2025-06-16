import 'package:hessa/core/utils/type_aliases.dart';
import 'package:hessa/features/auth/data/models/token_model.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';

class RefreshTokenResponse {
  TokenModel? tokens;
  UserModel? user;

  RefreshTokenResponse.fromJson(Json json) {
    tokens = TokenModel.fromJson(json);
    user = UserModel.fromJson(json["user"]);
  }
}
