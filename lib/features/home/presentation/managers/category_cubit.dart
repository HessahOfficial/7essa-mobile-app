import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  int selectedIndex = 0;

  List<PropertyModel> allProperties = [];
  List<PropertyModel> hotProperties = [];
  List<PropertyModel> restOfProperties = [];

  void setSelectedIndex({required int index}) {
    selectedIndex = index;
    emit(CategoryChange());
  }

  void setProperties({required List<PropertyModel> allProperties}) {
    this.allProperties = allProperties;
    hotProperties = [allProperties[0], allProperties[1], allProperties[2]];
    restOfProperties = allProperties.sublist(3);
    emit(CategoryFetch());
  }
}
