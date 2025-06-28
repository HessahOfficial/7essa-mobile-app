import 'package:hessa/core/utils/type_aliases.dart';

class MakeInvestmentRequest {
  final int numberOfShares;
  final String propertyId;

  MakeInvestmentRequest({
    required this.numberOfShares,
    required this.propertyId,
  });

  Json toJson() {
    return {"numberOfShares": numberOfShares};
  }
}
