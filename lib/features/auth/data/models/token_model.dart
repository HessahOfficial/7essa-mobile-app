import 'package:hessa/core/utils/type_aliases.dart';
import 'package:hive/hive.dart';

part 'token_model.g.dart';

@HiveType(typeId: 1)
class TokenModel {
  @HiveField(0)
  String? accessToken;

  @HiveField(1)
  String? refreshToken;

  TokenModel({this.accessToken, this.refreshToken});

  TokenModel.fromJson(Json json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }
}
