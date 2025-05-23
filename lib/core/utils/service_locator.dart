import 'package:get_it/get_it.dart';

import 'package:hessa/core/helpers/dio_helper.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/features/auth/data/repositories/auth_service.dart';
import 'package:hessa/features/home/data/repositories/property_service.dart';
import 'package:image_picker/image_picker.dart';

final getIt = GetIt.instance;

void setupServices() {
  getIt.registerSingleton<DioHelper>(DioHelper());

  getIt.registerSingleton<HiveHelper>(HiveHelper());

  getIt.registerSingleton<ImagePicker>(ImagePicker());

  getIt.registerSingleton<AuthService>(
    AuthService(helper: getIt.get<DioHelper>()),
  );

  getIt.registerSingleton<PropertyService>(
    PropertyService(dioHelper: getIt.get<DioHelper>()),
  );
}
