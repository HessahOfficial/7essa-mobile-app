import 'package:hessa/core/utils/type_aliases.dart';

class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  Json toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "phoneNumber": phoneNumber,
  };
}
