import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String message,
  required int type,
}) {
  Flushbar(
    borderRadius: BorderRadius.circular(15),
    flushbarPosition: FlushbarPosition.TOP,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    isDismissible: true,
    duration: Duration(seconds: 5),
    icon: Icon(
      type == 1 ? Icons.cancel_rounded : Icons.check_circle_rounded,
      color: Colors.white,
    ),
    barBlur: 5,
    backgroundColor: type == 1 ? Colors.red : Colors.green,
    message: message,

    margin: EdgeInsets.all(10),
  ).show(context);
}
