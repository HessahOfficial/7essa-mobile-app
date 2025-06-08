import 'package:hessa/core/utils/type_aliases.dart';

class ChangePinRequest {
  final num pin;

  ChangePinRequest({required this.pin});

  Json toJson() {
    return {"pin": pin};
  }
}
