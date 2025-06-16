import 'package:hessa/features/home/data/models/property_model.dart';

class GetPropertyResponse {
  PropertyModel? property;

  GetPropertyResponse.fromJson(json) {
    property = PropertyModel.fromJson(json["property"]);
  }
}
