import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hessa/features/favourite/data/models/delete_favourites_request.dart';
import 'package:hessa/features/favourite/data/models/delete_favourites_response.dart';
import 'package:hessa/features/favourite/data/models/get_all_favourites_request.dart';
import 'package:hessa/features/favourite/data/models/get_all_favourites_response.dart';
import 'package:hessa/features/home/data/models/add_to_favourites_request.dart';
import 'package:hessa/features/home/data/models/add_to_favourites_response.dart';
import 'package:hessa/features/home/data/models/get_all_properties_request.dart';
import 'package:hessa/features/home/data/models/get_all_properties_response.dart';
import 'package:hessa/features/home/data/repositories/property_service.dart';
import 'package:hessa/features/property/data/models/get_property_request.dart';
import 'package:hessa/features/property/data/models/get_property_response.dart';
import 'package:meta/meta.dart';

part 'property_event.dart';
part 'property_state.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  final PropertyService service;

  PropertyBloc(this.service) : super(PropertyInitial()) {
    on<GetAllPropertiesEvent>((event, emit) async {
      emit(GetAllPropertiesLoading());
      final response = await service.getAllProperties(request: event.request);
      response.fold(
        (failure) {
          emit(GetAllPropertiesFailure(message: failure.message));
        },
        (data) {
          emit(GetAllPropertiesSuccess(response: data));
        },
      );
    });

    on<GetNewAddedPropertiesEvent>((event, emit) async {
      emit(GetNewAddedPropertiesLoading());
      final response = await service.getAllProperties(request: event.request);
      response.fold(
        (failure) {
          emit(GetNewAddedPropertiesFailure(message: failure.message));
        },
        (data) {
          emit(GetNewAddedPropertiesSuccess(response: data));
        },
      );
    });

    on<GetBestInvestPropertiesEvent>((event, emit) async {
      emit(GetBestInvestPropertiesLoading());
      final response = await service.getAllProperties(request: event.request);
      response.fold(
        (failure) {
          emit(GetBestInvestPropertiesFailure(message: failure.message));
        },
        (data) {
          emit(GetBestInvestPropertiesSuccess(response: data));
        },
      );
    });

    on<AddToFavouritesEvent>((event, emit) async {
      emit(AddToFavouritesLoading());
      final response = await service.addToFavourites(request: event.request);
      response.fold(
        (failure) {
          emit(AddToFavouritesFailure(message: failure.message));
        },
        (data) {
          emit(AddToFavouritesSuccess(response: data));
        },
      );
    });

    on<GetAllFavouritesEvent>((event, emit) async {
      emit(GetAllFavouritesLoading());
      final response = await service.getAllFavourites(request: event.request);
      response.fold(
        (failure) {
          emit(GetAllFavouritesFailure(message: failure.message));
        },
        (data) {
          emit(GetAllFavouritesSuccess(response: data));
        },
      );
    });

    on<DeleteFavouritesEvent>((event, emit) async {
      emit(DeleteFavouritesLoading());
      final response = await service.deleteFavourites(request: event.request);
      response.fold(
        (failure) {
          emit(DeleteFavouritesFailure(message: failure.message));
        },
        (data) {
          emit(DeleteFavouritesSuccess(response: data));
        },
      );
    });

    on<GetPropertyEvent>((event, emit) async {
      emit(GetPropertyLoading());
      final response = await service.getProperty(request: event.request);
      response.fold(
        (failure) {
          emit(GetPropertyFailure(message: failure.message));
        },
        (data) {
          emit(GetPropertySuccess(response: data));
        },
      );
    });
  }
}
