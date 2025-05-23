import 'package:hessa/core/utils/type_aliases.dart';

class VerifyEmailRequest {
  final String email;

  VerifyEmailRequest({required this.email});

  Json toJson() => {"email": email};
}
