import 'package:hessa/core/utils/type_aliases.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';
import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/investment/data/models/displayed_share_price_model.dart';

class InvestmentModel {
  String? id;
  UserModel? userId;
  PropertyModel? propertyId;
  String? investmentStatus;
  int? numOfShares;
  DateTime? investmentDate;
  DateTime? lastPaymentDate;
  num? annualReturns;
  num? monthlyReturns;
  num? totalReturns;
  num? netGains;
  num? sharePrice;
  DisplayedSharePriceModel? displayingSharePrice;
  num? totalSharesPersantage;
  num? investmentAmount;

  InvestmentModel({
    this.id,
    this.annualReturns,
    this.displayingSharePrice,
    this.investmentAmount,
    this.investmentDate,
    this.investmentStatus,
    this.lastPaymentDate,
    this.monthlyReturns,
    this.netGains,
    this.numOfShares,
    this.propertyId,
    this.sharePrice,
    this.totalReturns,
    this.totalSharesPersantage,
    this.userId,
  });

  InvestmentModel.fromJson(Json json) {
    id = json["_id"];
    userId = UserModel.fromJson(json["userId"]);
    propertyId = PropertyModel.fromJson(json["propertyId"]);
    investmentStatus = json["investmentStatus"];
    investmentDate =
        json["investmentDate"] != null
            ? DateTime.parse(json["investmentDate"])
            : null;
    lastPaymentDate =
        json["lastPaymentDate"] != null
            ? DateTime.parse(json["lastPaymentDate"])
            : null;
    numOfShares = json["numOfShares"];
    annualReturns = json["annualReturns"];
    monthlyReturns = json["monthlyReturns"];
    totalReturns = json["totalReturns"];
    netGains = json["netGains"];
    sharePrice = json["sharePrice"];
    displayingSharePrice = DisplayedSharePriceModel.fromJson(
      json["displayingSharePrice"],
    );
    totalSharesPersantage = json["totalSharesPersantage"];
    investmentAmount = json["investmentAmount"];
  }
}
