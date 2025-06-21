import 'package:hessa/core/utils/type_aliases.dart';

class DisplayedSharePriceModel {
  String? ar;
  String? en;

  DisplayedSharePriceModel.fromJson(Json json) {
    ar = json["ar"];
    en = json["en"];
  }
}
