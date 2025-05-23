import 'package:hessa/core/utils/type_aliases.dart';
import 'package:hessa/features/home/data/models/property_model.dart';

class GetAllFavouritesResponse {
  final List<PropertyModel> favourites = [];

  GetAllFavouritesResponse.fromJson(Json json) {
    json["favourites"].forEach(
      (property) => {favourites.add(PropertyModel.fromJson(property))},
    );
  }
}
