import 'package:bloc/bloc.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/home/data/models/property_model.dart';

import 'package:meta/meta.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  List<PropertyModel> favourites = [];
  List<int> selectedIndices = [];
  bool selectionMode = false;

  List<String> getSelectedIds() {
    List<String> selectedIds = [];
    for (int index in selectedIndices) {
      selectedIds.add(favourites[index].id!);
    }
    return selectedIds;
  }

  bool isFavourite({required String propertyId}) {
    final currentUser = getIt.get<HiveHelper>().currentUser;
    return currentUser!.favourites!.contains(propertyId);
  }

  void deleteSelectedIndices() {
    List<PropertyModel>? selectedProperties = [];
    for (int index in selectedIndices) {
      selectedProperties.add(favourites[index]);
    }
    for (PropertyModel selectedProperty in selectedProperties) {
      favourites.removeWhere((property) => property.id == selectedProperty.id);
    }
    selectedProperties = null;
    selectionMode = false;
    selectedIndices = [];
  }

  bool checkWasSelected(PropertyModel property) {
    int selectedIndex = favourites.indexOf(property);
    return selectedIndices.contains(selectedIndex);
  }

  void setFavourites({required List<PropertyModel> list}) {
    favourites = list;
    emit(FavouriteFetch());
  }

  void addSelectedProperty(PropertyModel property) {
    int selectedIndex = favourites.indexOf(property);
    bool foundIndex = selectedIndices.contains(selectedIndex);
    if (!foundIndex) {
      selectedIndices.add(selectedIndex);
      if (selectedIndices.isNotEmpty) {
        selectionMode = true;
      }
    }
    emit(FavouriteSelect());
  }

  void removeSelectedProperty(PropertyModel property) {
    int selectedIndex = favourites.indexOf(property);
    bool foundIndex = selectedIndices.contains(selectedIndex);
    if (foundIndex) {
      selectedIndices.remove(selectedIndex);
      if (selectedIndices.isEmpty) {
        selectionMode = false;
      }
    }
    emit(FavouriteSelect());
  }
}
