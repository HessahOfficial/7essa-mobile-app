import 'package:hessa/core/utils/type_aliases.dart';

class PropertyQueryModel {
  String? title;
  String? status;
  String? ownerId;
  int? numberOfRooms;
  int? numberOfbeds;
  int? numberOfKitchens;
  int? numberOfBathrooms;
  int? minAvailableShares;
  int? maxAvailableShares;
  double? minPrice;
  double? maxPrice;
  double? minPricePerShare;
  double? maxPricePerShare;
  double? minRentalIncome;
  double? maxRentalIncome;
  double? minArea;
  double? maxArea;
  double? minYearlyPayment;
  double? maxYearlyPayment;
  bool? isRented;

  PropertyQueryModel({
    this.isRented,
    this.maxArea,
    this.maxAvailableShares,
    this.maxPrice,
    this.minPrice,
    this.maxPricePerShare,
    this.maxRentalIncome,
    this.maxYearlyPayment,
    this.minArea,
    this.minAvailableShares,
    this.minPricePerShare,
    this.minRentalIncome,
    this.minYearlyPayment,
    this.numberOfBathrooms,
    this.numberOfKitchens,
    this.numberOfRooms,
    this.numberOfbeds,
    this.status,
    this.title,
    this.ownerId,
  });

  Json toJson() {
    return {
      "title": title,
      "status": status,
      "ownerId": ownerId,
      "numOfKitchens": numberOfKitchens,
      "numOfBathrooms": numberOfBathrooms,
      "numOfBeds": numberOfbeds,
      "numOfRooms": numberOfRooms,
      "isRented": isRented,
      "minPrice": minPrice,
      "maxPrice": maxPrice,
      "minYearlyPayment": minYearlyPayment,
      "maxYearlyPayment": maxYearlyPayment,
      "minArea": minArea,
      "maxArea": maxArea,
      "minAvailableShares": minAvailableShares,
      "maxAvailableShares": maxAvailableShares,
      "minPricePerShare": minPricePerShare,
      "maxPricePerShare": maxPricePerShare,
      "minRentalIncome": minRentalIncome,
      "maxRentalIncome": maxRentalIncome,
    };
  }
}
