import 'package:hessa/core/utils/type_aliases.dart';

class RefreshTokenRequest {
  final String refreshToken;

  RefreshTokenRequest({required this.refreshToken});

  Json toJson() {
    return {"refreshToken": refreshToken};
  }
}
