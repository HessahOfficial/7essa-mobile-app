import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';

part 'launch_state.dart';

class LaunchCubit extends Cubit<LaunchState> {
  LaunchCubit() : super(LaunchInitial());

  Future<void> launch({required BuildContext context}) async {
    await getIt.get<HiveHelper>().storeIsFirstLaunch(isFirstLaunch: false);
    emit(LaunchActive());
  }
}
