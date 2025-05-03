import 'package:bloc/bloc.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  Future<void> changeLocale({required bool isArabic}) async {
    final locale = isArabic ? "ar" : "en";
    await getIt.get<HiveHelper>().changeLocale(locale: locale);
    emit(LocaleChange());
  }

  Future<void> changeTheme({required bool isDark}) async {
    await getIt.get<HiveHelper>().changeTheme(isDark: isDark);
    emit(ThemeChange());
  }
}
