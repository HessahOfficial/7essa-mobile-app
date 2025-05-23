import 'package:hessa/core/utils/type_aliases.dart';

class GetAllFavouritesRequest {
  final String userId;

  GetAllFavouritesRequest({required this.userId});

  Json toJson() {
    return {"id": userId};
  }
}
