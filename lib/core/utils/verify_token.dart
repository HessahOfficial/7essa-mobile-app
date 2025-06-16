import 'package:jwt_decoder/jwt_decoder.dart';

bool verifyToken({required String accessToken}) {
  return JwtDecoder.isExpired(accessToken);
}
