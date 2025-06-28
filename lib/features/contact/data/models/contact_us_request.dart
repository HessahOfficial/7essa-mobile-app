import 'package:hessa/core/utils/type_aliases.dart';

class ContactUsRequest {
  final String fullname;
  final String email;
  final String phoneNumber;
  final String subject;
  final String messageBody;

  ContactUsRequest({
    required this.fullname,
    required this.email,
    required this.phoneNumber,
    required this.subject,
    required this.messageBody,
  });

  Json toJson() {
    return {
      "fullName": fullname,
      "email": email,
      "phoneNumber": phoneNumber,
      "subject": subject,
      "messageBody": messageBody,
    };
  }
}
