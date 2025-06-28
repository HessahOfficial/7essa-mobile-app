import 'package:hessa/features/wallet/data/models/payment_model.dart';

class GetPaymentHistoryResponse {
  List<PaymentModel> payments = [];

  GetPaymentHistoryResponse.fromJson(List<dynamic> json) {
    for (var payment in json) {
      payments.add(PaymentModel.fromJson(payment));
    }

    payments.sort((a, b) => b.paymentDate!.compareTo(a.paymentDate!));
  }
}
