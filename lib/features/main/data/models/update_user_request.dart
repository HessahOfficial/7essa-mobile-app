import 'package:hessa/core/utils/type_aliases.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';

class UpdateUserRequest {
  final UserModel user;
  final Json params;

  UpdateUserRequest({required this.user, required this.params});

  Json toJson() {
    return {
      "username": user.username,
      "pin": user.pin,
      "balance": user.balance,
      "isInvestor": user.isInvestor,
      "phoneNumber": user.phoneNumber,
    };
  }
}
