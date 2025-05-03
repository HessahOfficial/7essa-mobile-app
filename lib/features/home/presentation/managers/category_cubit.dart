import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  int selectedIndex = 0;

  void setSelectedIndex({required int index}) {
    selectedIndex = index;
    emit(CategoryChange());
  }
}
