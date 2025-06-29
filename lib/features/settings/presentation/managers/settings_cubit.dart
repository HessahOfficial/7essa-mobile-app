import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:meta/meta.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<void> downloadAndOpenPDF() async {
    try {
      final byteData = await rootBundle.load(
        'assets/Hessah_Terms_and_Conditions.pdf',
      );

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/Hessah_Terms_and_Conditions.pdf';

      final file = File(filePath);
      await file.writeAsBytes(byteData.buffer.asUint8List());

      final result = await OpenFile.open(filePath);
      print(result);
    } catch (e) {
      print("Error opening PDF: $e");
    }
  }
}
