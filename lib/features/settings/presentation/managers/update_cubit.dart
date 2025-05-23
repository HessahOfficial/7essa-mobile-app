import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_state.dart';

class UpdateCubit extends Cubit<UpdateState> {
  UpdateCubit() : super(UpdateInitial());

  bool isUpdate = false;

  void updateDetails({required bool isUpdate}) {
    print(isUpdate);
    this.isUpdate = isUpdate;
    emit(UpdateChanged());
  }
}
