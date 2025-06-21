import 'package:hessa/core/utils/type_aliases.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';

class GetAllPartnersResponse {
  List<UserModel> partners = [];

  GetAllPartnersResponse.fromJson(List<dynamic> json) {
    for (var partner in json) {
      partners.add(UserModel.fromJson(partner));
    }
  }
}
