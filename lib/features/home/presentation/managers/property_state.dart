part of 'property_bloc.dart';

@immutable
abstract class PropertyState {}

class PropertyInitial extends PropertyState {}

class GetAllPropertiesLoading extends PropertyState {}

class GetAllPropertiesSuccess extends PropertyState {
  final GetAllPropertiesResponse response;

  GetAllPropertiesSuccess({required this.response});
}

class GetAllPropertiesFailure extends PropertyState {
  final String message;

  GetAllPropertiesFailure({required this.message});
}

class AddToFavouritesLoading extends PropertyState {}

class AddToFavouritesSuccess extends PropertyState {
  final AddToFavouritesResponse response;

  AddToFavouritesSuccess({required this.response});
}

class AddToFavouritesFailure extends PropertyState {
  final String message;

  AddToFavouritesFailure({required this.message});
}

class GetAllFavouritesLoading extends PropertyState {}

class GetAllFavouritesSuccess extends PropertyState {
  final GetAllFavouritesResponse response;

  GetAllFavouritesSuccess({required this.response});
}

class GetAllFavouritesFailure extends PropertyState {
  final String message;

  GetAllFavouritesFailure({required this.message});
}

class DeleteFavouritesLoading extends PropertyState {}

class DeleteFavouritesSuccess extends PropertyState {
  final DeleteFavouritesResponse response;

  DeleteFavouritesSuccess({required this.response});
}

class DeleteFavouritesFailure extends PropertyState {
  final String message;

  DeleteFavouritesFailure({required this.message});
}
