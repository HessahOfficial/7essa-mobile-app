import 'package:hessa/core/utils/type_aliases.dart';

class InvestmentQueryModel {
  String? userId;
  String? propertyName;
  String? investmentStatus;
  int? maxNumOfShares;
  int? minNumOfShares;
  DateTime? minInvestmentDate;
  DateTime? maxInvestmentDate;

  InvestmentQueryModel({
    this.investmentStatus,
    this.maxInvestmentDate,
    this.maxNumOfShares,
    this.minInvestmentDate,
    this.minNumOfShares,
    this.propertyName,
    this.userId,
  });

  Json toJson() {
    return {
      "userId": userId,
      "propertyName": propertyName,
      "maxNumOfShares": maxNumOfShares,
      "minNumOfShares": minNumOfShares,
      "investmentStatus": investmentStatus,
      "minInvestmentDate": minInvestmentDate,
      "maxInvestmentDate": maxInvestmentDate,
    };
  }
}
