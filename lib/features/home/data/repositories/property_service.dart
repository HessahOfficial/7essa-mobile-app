import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hessa/core/errors/failures.dart';
import 'package:hessa/core/helpers/dio_helper.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/endpoints.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/favourite/data/models/delete_favourites_request.dart';
import 'package:hessa/features/favourite/data/models/delete_favourites_response.dart';
import 'package:hessa/features/favourite/data/models/get_all_favourites_request.dart';
import 'package:hessa/features/favourite/data/models/get_all_favourites_response.dart';
import 'package:hessa/features/home/data/models/add_to_favourites_request.dart';
import 'package:hessa/features/home/data/models/add_to_favourites_response.dart';
import 'package:hessa/features/home/data/models/get_all_properties_request.dart';
import 'package:hessa/features/home/data/models/get_all_properties_response.dart';
import 'package:hessa/features/home/data/repositories/property_repository.dart';
import 'package:hessa/features/property/data/models/get_property_request.dart';
import 'package:hessa/features/property/data/models/get_property_response.dart';

class PropertyService implements PropertyRepository {
  final DioHelper helper;

  PropertyService({required this.helper});

  @override
  Future<Either<Failure, GetAllPropertiesResponse>> getAllProperties({
    required GetAllPropertiesRequest request,
  }) async {
    try {
      final tokens = getIt.get<HiveHelper>().token;
      final options = helper.getDioOptions(token: tokens!.accessToken!);
      final data = await helper.get(
        endpoint: Endpoints.getAllProperties,
        options: options,
        params: request.toJson(),
      );
      final response = GetAllPropertiesResponse.fromJson(
        data["data"]["properties"],
      );
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(exception: e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddToFavouritesResponse>> addToFavourites({
    required AddToFavouritesRequest request,
  }) async {
    try {
      final tokens = getIt.get<HiveHelper>().token;
      final options = helper.getDioOptions(token: tokens!.accessToken!);
      final data = await helper.post(
        endpoint: Endpoints.addToFavourites
            .replaceAll(':userId', request.userId)
            .replaceAll(':propertyId', request.propertyId),
        options: options,
      );
      final currentUser = getIt.get<HiveHelper>().currentUser;
      currentUser!.favourites!.add(request.propertyId);
      await getIt.get<HiveHelper>().storeCurrentUser(
        user: currentUser,
        tokens: tokens,
      );
      final response = AddToFavouritesResponse.fromJson(data);
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(exception: e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetAllFavouritesResponse>> getAllFavourites({
    required GetAllFavouritesRequest request,
  }) async {
    try {
      final tokens = getIt.get<HiveHelper>().token;
      final options = helper.getDioOptions(token: tokens!.accessToken!);
      final data = await helper.get(
        endpoint: Endpoints.getAllFavourites.replaceAll(
          ':userId',
          request.userId,
        ),
        options: options,
      );
      final response = GetAllFavouritesResponse.fromJson(data['data']);
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(exception: e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteFavouritesResponse>> deleteFavourites({
    required DeleteFavouritesRequest request,
  }) async {
    try {
      final tokens = getIt.get<HiveHelper>().token;
      final options = getIt.get<DioHelper>().getDioOptions(
        token: tokens!.accessToken!,
      );
      final currentUser = getIt.get<HiveHelper>().currentUser;
      final data = await helper.delete(
        endpoint: Endpoints.deleteFavourites.replaceAll(
          ':userId',
          currentUser!.id!,
        ),
        body: request.toJson(),
        options: options,
      );
      for (var id in request.properties) {
        currentUser.favourites!.removeWhere((propertyId) => propertyId == id);
      }
      await getIt.get<HiveHelper>().storeCurrentUser(
        user: currentUser,
        tokens: tokens,
      );
      final response = DeleteFavouritesResponse.fromJson(data['data']);
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(exception: e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetPropertyResponse>> getProperty({
    required GetPropertyRequest request,
  }) async {
    try {
      final tokens = getIt.get<HiveHelper>().token;
      final options = helper.getDioOptions(token: tokens!.accessToken!);
      final data = await helper.get(
        endpoint: Endpoints.getPropertyById.replaceAll(
          ":id",
          request.propertyId,
        ),
        options: options,
      );
      final response = GetPropertyResponse.fromJson(data["data"]);
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(exception: e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }
}
