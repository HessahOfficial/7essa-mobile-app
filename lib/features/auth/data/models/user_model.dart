import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String accessToken;

  @HiveField(1)
  String refreshToken;

  @HiveField(2)
  String emailAddress;

  @HiveField(3)
  String name;

  @HiveField(4)
  String phoneNumber;

  UserModel({
    required this.accessToken,
    required this.refreshToken,
    required this.emailAddress,
    required this.phoneNumber,
    required this.name,
  });
}
