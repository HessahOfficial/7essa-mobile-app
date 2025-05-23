import 'package:hessa/core/utils/type_aliases.dart';

class RegisterRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String username;

  RegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.username,
  });

  Json toJson() => {
    "username": username,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
  };
}
