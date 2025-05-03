import 'package:hessa/core/utils/type_aliases.dart';

class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Json toJson() => {"email": email, "password": password};
}
