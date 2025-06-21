import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:meta/meta.dart';

import 'package:hessa/features/home/data/models/get_all_properties_request.dart';
import 'package:hessa/features/home/data/repositories/property_service.dart';
import 'package:hessa/features/home/data/models/get_all_properties_response.dart';
import 'package:hessa/features/home/data/models/property_query_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  PropertyQueryModel initialQuery = PropertyQueryModel();

  final PropertyService service;

  int statusIndex = -1;
  String? statusText;
  List<PropertyModel> filteredProperties = [];

  void setQuery({required PropertyQueryModel query}) {
    initialQuery = query;
  }

  void setStatus({required int index}) {
    statusIndex = index;

    switch (index) {
      case 0:
        statusText = "Available";

        break;
      case 1:
        statusText = "Funded";

        break;
      case 2:
        statusText = "Exited";

        break;
      default:
        statusText = null;
    }

    emit(ChangeStatus());
  }

  SearchBloc({required this.service}) : super(SearchInitial()) {
    on<GetFilteredPropertiesEvent>((event, emit) async {
      emit(GetFilteredPropertiesLoading());
      final response = await service.getAllProperties(request: event.request);
      response.fold(
        (failure) {
          emit(GetFilteredPropertiesFailure(message: failure.message));
        },
        (data) {
          filteredProperties = data.properties;
          emit(GetFilteredPropertiesSuccess(response: data));
        },
      );
    });
  }
}
