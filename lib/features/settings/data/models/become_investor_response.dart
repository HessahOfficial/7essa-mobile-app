import 'package:hessa/core/utils/type_aliases.dart';

class BecomeInvestorResponse {
  String? username;
  String? phoneNumber;
  String? email;
  String? avatar;
  String? nationalId;
  bool? isInvestor;

  BecomeInvestorResponse.fromJson(Json json) {
    username = json["username"];
    phoneNumber = json["phoneNUmber"];
    email = json["email"];
    avatar = json["avatar"];
    nationalId = json["nationalId"];
    isInvestor = json["isInvestor"];
  }
}
