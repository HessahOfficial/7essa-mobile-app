import 'package:hessa/core/utils/type_aliases.dart';
import 'package:hessa/features/home/data/models/property_model.dart';

class GetAllPropertiesResponse {
  final List<PropertyModel> properties = [];

  GetAllPropertiesResponse.fromJson(List<dynamic> jsonList) {
    for (var element in jsonList) {
      properties.add(PropertyModel.fromJson(element));
    }
  }
}
