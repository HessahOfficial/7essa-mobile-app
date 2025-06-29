import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';

class CreatePaymentRequest {
  final double amount;
  final String paymentMethod;
  final String paymentType;
  final File? screenshot;

  CreatePaymentRequest({
    this.screenshot,
    required this.amount,
    required this.paymentMethod,
    required this.paymentType,
  });

  Future<FormData> toJson() async {
    String? fileName;

    if (paymentType == "deposit") {
      fileName = basename(screenshot!.path);
    }

    FormData formData = FormData.fromMap({
      'screenshot':
          paymentType == "deposit"
              ? await MultipartFile.fromFile(
                screenshot!.path,
                filename: fileName!,
              )
              : null,
      "amount": amount.toInt(),
      "paymentMethod": paymentMethod,
      "paymentType": paymentType,
    });

    return formData;
  }
}
