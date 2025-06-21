import 'package:hessa/core/utils/type_aliases.dart';
import 'package:hessa/features/home/data/models/property_query_model.dart';

class GetAllPropertiesRequest {
  final PropertyQueryModel? query;

  GetAllPropertiesRequest({this.query});

  Json toJson() {
    if (query != null) return query!.toJson();
    return {};
  }
}
