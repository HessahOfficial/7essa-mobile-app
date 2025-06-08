import 'package:hessa/core/utils/type_aliases.dart';

class BecomeInvestorRequest {
  final String nationalId;

  BecomeInvestorRequest({required this.nationalId});

  Json toJson() {
    return {"nationalId": nationalId};
  }
}
