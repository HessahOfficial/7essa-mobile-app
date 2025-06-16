import 'package:dartz/dartz.dart';
import 'package:hessa/core/errors/failures.dart';
import 'package:hessa/features/favourite/data/models/delete_favourites_request.dart';
import 'package:hessa/features/favourite/data/models/delete_favourites_response.dart';
import 'package:hessa/features/favourite/data/models/get_all_favourites_request.dart';
import 'package:hessa/features/favourite/data/models/get_all_favourites_response.dart';
import 'package:hessa/features/home/data/models/add_to_favourites_request.dart';
import 'package:hessa/features/home/data/models/add_to_favourites_response.dart';
import 'package:hessa/features/home/data/models/get_all_properties_request.dart';
import 'package:hessa/features/home/data/models/get_all_properties_response.dart';
import 'package:hessa/features/property/data/models/get_property_request.dart';
import 'package:hessa/features/property/data/models/get_property_response.dart';

abstract class PropertyRepository {
  Future<Either<Failure, GetAllPropertiesResponse>> getAllProperties({
    required GetAllPropertiesRequest request,
  });

  Future<Either<Failure, AddToFavouritesResponse>> addToFavourites({
    required AddToFavouritesRequest request,
  });

  Future<Either<Failure, GetAllFavouritesResponse>> getAllFavourites({
    required GetAllFavouritesRequest request,
  });

  Future<Either<Failure, DeleteFavouritesResponse>> deleteFavourites({
    required DeleteFavouritesRequest request,
  });

  Future<Either<Failure, GetPropertyResponse>> getProperty({
    required GetPropertyRequest request,
  });
}
