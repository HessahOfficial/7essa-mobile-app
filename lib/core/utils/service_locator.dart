import 'package:get_it/get_it.dart';

import 'package:hessa/core/helpers/dio_helper.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/features/auth/data/repositories/auth_service.dart';

final getIt = GetIt.instance;

void setupServices() {
  getIt.registerSingleton<DioHelper>(DioHelper());

  getIt.registerSingleton<HiveHelper>(HiveHelper());

  getIt.registerSingleton<AuthService>(
    AuthService(helper: getIt.get<DioHelper>()),
  );
}
