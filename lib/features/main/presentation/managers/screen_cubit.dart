import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'screen_state.dart';

class ScreenCubit extends Cubit<ScreenState> {
  ScreenCubit() : super(ScreenInitial());

  int currentIndex = 0;

  void setCurrentIndex({required int index}) {
    currentIndex = index;
    switch (index) {
      case 0:
        emit(HomeState());
        break;
      case 1:
        emit(FavouriteState());
        break;
      case 2:
        emit(WalletState());
        break;
      case 3:
        emit(SettingState());
        break;
    }
  }
}
