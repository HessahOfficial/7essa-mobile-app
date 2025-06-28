import 'package:hessa/core/utils/type_aliases.dart';

class PaymentModel {
  String? id;
  String? userId;
  String? paymentType;
  String? paymentMethod;
  String? currency;
  String? paymentStatus;
  DateTime? paymentDate;
  String? displayingAmount;
  num? amount;

  PaymentModel({
    this.amount,
    this.currency,
    this.displayingAmount,
    this.paymentDate,
    this.paymentMethod,
    this.paymentType,
    this.paymentStatus,
    this.userId,
    this.id,
  });

  PaymentModel.fromJson(Json json) {
    id = json["_id"];
    userId = json["userId"];
    currency = json["currency"];
    displayingAmount = json["displayingAmount"];
    paymentDate = DateTime.parse(json["paymentDate"]);
    paymentMethod = json["paymentMethod"];
    paymentStatus = json["paymentStatus"];
    paymentType = json["paymentType"];
    amount = json["amount"];
  }
}
