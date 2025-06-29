import 'package:flutter/material.dart';
import 'package:hessa/generated/l10n.dart';

class Validator {
  final BuildContext context;

  Validator({required this.context});

  String? validateEmailAddress({required String email}) {
    String? message;
    RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (email.trim().isEmpty) {
      message = S.of(context).requiredEmail;
    } else if (!regex.hasMatch(email)) {
      message = S.of(context).invalidEmail;
    }
    return message;
  }

  String? validatePassword({required String password}) {
    String? message;
    RegExp regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$');
    if (password.trim().isEmpty) {
      message = S.of(context).requiredPassword;
    } else if (!regex.hasMatch(password)) {
      message = S.of(context).invalidPassword;
    }
    return message;
  }

  String? validateUsername({required String username}) {
    String? message;
    RegExp regex = RegExp(r'^.{3,}$');
    if (username.trim().isEmpty) {
      message = S.of(context).requiredUsername;
    } else if (!regex.hasMatch(username)) {
      message = S.of(context).invalidUsername;
    }
    return message;
  }

  String? validateFullname({required String fullname}) {
    String? message;
    RegExp regex = RegExp(r'^.{3,}$');
    if (fullname.trim().isEmpty) {
      message = S.of(context).requiredFullname;
    } else if (!regex.hasMatch(fullname)) {
      message = S.of(context).invalidFullname;
    }
    return message;
  }

  String? validatePhone({required String phone}) {
    String? message;
    RegExp regex = RegExp(r'^0\d{10}$');
    if (phone.trim().isEmpty) {
      message = S.of(context).requiredPhone;
    } else if (!regex.hasMatch(phone)) {
      message = S.of(context).invalidPhone;
    }
    return message;
  }

  String? validateVodafoneNumber({required String phone}) {
    String? message;
    RegExp regex = RegExp(r'^010\d{8}$');
    if (phone.trim().isEmpty) {
      message = S.of(context).requiredPhone;
    } else if (!regex.hasMatch(phone)) {
      message = S.of(context).invalidVodafone;
    }
    return message;
  }

  String? validateInstapay({required String instapay}) {
    String? message;
    if (instapay.trim().isEmpty) {
      message = S.of(context).requiredInstapay;
    } else if (!instapay.endsWith("@instapay")) {
      message = S.of(context).invalidInstapay;
    }
    return message;
  }

  String? validateCreditCard({required String credit}) {
    String? message;
    RegExp regex = RegExp(r'^\d{14}$');
    if (credit.trim().isEmpty) {
      message = S.of(context).requiredCredit;
    } else if (!regex.hasMatch(credit)) {
      message = S.of(context).invalidCredit;
    }
    return message;
  }

  String? validateAmount({
    required String amount,
    required String paymentType,
  }) {
    String? message;
    if (amount.trim().isEmpty) {
      message = S.of(context).requiredAmount;
    } else if (paymentType == "deposit" && int.parse(amount) < 1000) {
      message = S.of(context).invalidAmount;
    } else if (paymentType == "withdraw" && int.parse(amount) == 0) {
      message = S.of(context).invalidAmount2;
    }
    return message;
  }

  String? validateMessage({required String message}) {
    String? anotherMessage;
    if (message.trim().isEmpty) {
      anotherMessage = S.of(context).requiredMessage;
    }
    return anotherMessage;
  }

  String? validateNationalId({required String nationalId}) {
    String? message;
    RegExp regex = RegExp(r'^[1-9]\d{13}$');
    if (nationalId.trim().isEmpty) {
      message = S.of(context).requiredNationalId;
    } else if (!regex.hasMatch(nationalId)) {
      message = S.of(context).invalidNationalId;
    }
    return message;
  }

  String? validatePin({required String? otp}) {
    String? message;
    RegExp regex = RegExp(r'^[1-9]\d{5}$');
    if (otp!.trim().isEmpty) {
      message = S.of(context).requiredPin;
    } else if (!regex.hasMatch(otp)) {
      message = S.of(context).invalidPin;
    }
    return message;
  }

  String? validateSubject({required String? subject}) {
    String? message;
    if (subject!.trim().isEmpty) {
      message = S.of(context).requiredSubject;
    }

    return message;
  }
}
