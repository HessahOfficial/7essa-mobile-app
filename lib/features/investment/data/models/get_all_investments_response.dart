import 'package:hessa/features/investment/data/models/investment_model.dart';

class GetAllInvestmentsResponse {
  List<InvestmentModel> investments = [];

  GetAllInvestmentsResponse.fromJson(List<dynamic> json) {
    for (var investment in json) {
      investments.add(InvestmentModel.fromJson(investment));
    }
  }
}
