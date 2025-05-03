import 'package:hessa/core/utils/type_aliases.dart';

class ForgotPasswordRequest {
  final String? email;

  ForgotPasswordRequest({required this.email});

  Json toJson() => {"email": email};
}
