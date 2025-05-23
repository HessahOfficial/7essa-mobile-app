import 'package:hessa/core/utils/type_aliases.dart';

class AddToFavouritesResponse {
  String? message;

  AddToFavouritesResponse({required this.message});

  AddToFavouritesResponse.fromJson(Json json) {
    message = json["message"];
  }
}
