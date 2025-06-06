import 'package:hessa/core/utils/type_aliases.dart';

class ShowBalanceRequest {
  final int pin;

  ShowBalanceRequest({required this.pin});

  Json toJson() {
    return {"pin": pin};
  }
}
