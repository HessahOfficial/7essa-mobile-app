import 'package:hessa/core/utils/type_aliases.dart';

class AddToFavouritesRequest {
  final String propertyId;
  final String userId;

  AddToFavouritesRequest({required this.userId, required this.propertyId});
}
