import 'package:hessa/core/utils/type_aliases.dart';

class DeleteFavouritesRequest {
  final List<String> properties;

  DeleteFavouritesRequest({required this.properties});

  Json toJson() {
    return {"properties": properties};
  }
}
