import 'package:hessa/core/utils/type_aliases.dart';

class DeleteFavouritesResponse {
  List<dynamic>? favourites;

  DeleteFavouritesResponse.fromJson(Json json) {
    favourites = json["favourites"];
  }
}
