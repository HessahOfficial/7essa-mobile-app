import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(SliderInitial());

  int pageIndex = 0;

  void changePageIndex({required int index}) {
    pageIndex = index;
    emit(ChangePage());
  }
}
