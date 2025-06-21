import 'package:hessa/core/utils/type_aliases.dart';
import 'package:hessa/features/investment/data/models/investment_query_model.dart';

class GetAllInvestmentsRequest {
  InvestmentQueryModel? query;

  GetAllInvestmentsRequest({this.query});

  Json toJson() {
    if (query != null) return query!.toJson();
    return {};
  }
}
