part of 'property_bloc.dart';

@immutable
abstract class PropertyEvent {}

class GetAllPropertiesEvent extends PropertyEvent {
  final GetAllPropertiesRequest request;

  GetAllPropertiesEvent({required this.request});
}

class AddToFavouritesEvent extends PropertyEvent {
  final AddToFavouritesRequest request;

  AddToFavouritesEvent({required this.request});
}

class GetAllFavouritesEvent extends PropertyEvent {
  final GetAllFavouritesRequest request;

  GetAllFavouritesEvent({required this.request});
}

class DeleteFavouritesEvent extends PropertyEvent {
  final DeleteFavouritesRequest request;

  DeleteFavouritesEvent({required this.request});
}

class GetPropertyEvent extends PropertyEvent {
  final GetPropertyRequest request;

  GetPropertyEvent({required this.request});
}

class GetNewAddedPropertiesEvent extends PropertyEvent {
  final GetAllPropertiesRequest request;

  GetNewAddedPropertiesEvent({required this.request});
}

class GetBestInvestPropertiesEvent extends PropertyEvent {
  final GetAllPropertiesRequest request;

  GetBestInvestPropertiesEvent({required this.request});
}
