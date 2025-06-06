import 'package:hessa/core/utils/type_aliases.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? firstName;

  @HiveField(2)
  String? lastName;

  @HiveField(3)
  String? fullName;

  @HiveField(4)
  String? username;

  @HiveField(5)
  String? email;

  @HiveField(6)
  String? avatar;

  @HiveField(7)
  String? pin;

  @HiveField(8)
  String? role;

  @HiveField(9)
  String? activity;

  @HiveField(10)
  String? nationalId;

  @HiveField(11)
  String? phoneNumber;

  @HiveField(12)
  bool? emailVerified;

  @HiveField(13)
  bool? isInvestor;

  @HiveField(14)
  num? balance;

  @HiveField(15)
  String? lastLogin;

  @HiveField(16)
  List<dynamic>? favourites;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.username,
    this.email,
    this.avatar,
    this.pin,
    this.role,
    this.activity,
    this.nationalId,
    this.phoneNumber,
    this.emailVerified,
    this.isInvestor,
    this.balance,
    this.lastLogin,
    this.favourites,
  });

  UserModel.fromJson(Json json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    fullName = json['fullName'];
    email = json['email'];
    avatar = json['avatar'];
    role = json['role'];
    pin = json['pin'].toString();
    activity = json['activity'];
    emailVerified = json['emailVerified'];
    isInvestor = json['isInvestor'];
    balance = json['balance'];
    lastLogin = json['lastLogin'];
    favourites = json["favourites"] ?? [];
  }

  @override
  String toString() {
    return """
    UserModel(
      id: $id,
      firstName: $firstName,
      lastName: $lastName,
      username: $username,
      fullName: $fullName,
      email: $email,
      avatar: $avatar,
      role: $role,
      pin: $pin,
      activity: $activity,
      emailVerified: $emailVerified,
      isInvestor: $isInvestor,
      balance: $balance,
      lastLogin: $lastLogin
      favourites: $favourites
    )
    """;
  }
}
