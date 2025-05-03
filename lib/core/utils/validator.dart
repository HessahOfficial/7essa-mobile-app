import 'package:flutter/material.dart';
import 'package:hessa/generated/l10n.dart';

class Validator {
  final BuildContext context;

  Validator({required this.context});

  String? validateEmailAddress({required String email}) {
    String? message;
    RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (email.isEmpty) {
      message = S.of(context).requiredEmail;
    } else if (!regex.hasMatch(email)) {
      message = S.of(context).invalidEmail;
    }
    return message;
  }

  String? validatePassword({required String password}) {
    String? message;
    RegExp regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$');
    if (password.isEmpty) {
      message = S.of(context).requiredPassword;
    } else if (!regex.hasMatch(password)) {
      message = S.of(context).invalidPassword;
    }
    return message;
  }

  String? validateUsername({required String username}) {
    String? message;
    RegExp regex = RegExp(r'^.{3,}$');
    if (username.isEmpty) {
      message = S.of(context).requiredUsername;
    } else if (!regex.hasMatch(username)) {
      message = S.of(context).invalidUsername;
    }
    return message;
  }

  String? validatePhone({required String phone}) {
    String? message;
    RegExp regex = RegExp(r'^0\d{10}$');
    if (phone.isEmpty) {
      message = S.of(context).requiredPhone;
    } else if (!regex.hasMatch(phone)) {
      message = S.of(context).invalidPhone;
    }
    return message;
  }

  String? validateMessage({required String message}) {
    String? anotherMessage;
    if (message.isEmpty) {
      anotherMessage = "Message field is required!";
    }
    return anotherMessage;
  }

  String? validateNationalId({required String nationalId}) {
    String? message;
    RegExp regex = RegExp(r'^[1-9]\d{13}$');
    if (nationalId.isEmpty) {
      message = "Phone field is required!";
    } else if (!regex.hasMatch(nationalId)) {
      message = "Invalid National Id!";
    }
    return message;
  }

  String? validateOtp({required String? otp}) {
    String? message;
    RegExp regex = RegExp(r'^[1-9]\d{5}$');
    if (otp!.isEmpty) {
      message = "Otp field is required!";
    } else if (!regex.hasMatch(otp)) {
      message = "Invalid otp code!";
    }
    return message;
  }
}
