import 'package:hessa/core/utils/type_aliases.dart';

class ShowBalanceResponse {
  num? balance;

  ShowBalanceResponse.fromJson(Json json) {
    balance = json["balance"];
  }
}
