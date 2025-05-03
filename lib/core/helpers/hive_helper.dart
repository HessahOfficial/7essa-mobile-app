import 'package:hessa/features/auth/data/models/user_model.dart';
import 'package:hive/hive.dart';

class HiveHelper {
  final _currentUserBox = "CURRENT_USER";
  final _currentUserKey = "USER";
  final _settingsBox = "CURRENT_USER";
  final _localeKey = "LOCALE";
  final _themeKey = "THEME";

  bool? isDark;
  String? locale;

  Future<void> initializeBoxes() async {
    await Hive.openBox(_currentUserBox);
    final settingsBox = await Hive.openBox(_settingsBox);
    isDark = settingsBox.get(_themeKey);
    print("Dark Mode: $isDark");
    locale = settingsBox.get(_localeKey);
    print("Language: $locale");
  }

  Future<void> changeTheme({required bool isDark}) async {
    final box = Hive.box(_settingsBox);
    box.put(_themeKey, isDark);
    this.isDark = isDark;
    print("Dark Mode: $isDark");
  }

  Future<void> changeLocale({required String locale}) async {
    final box = Hive.box(_settingsBox);
    box.put(_localeKey, locale);
    this.locale = locale;
    print("Language: $locale");
  }

  Future<void> storeCurrentUser({required UserModel user}) async {
    final box = Hive.box(_currentUserBox);
    if (box.isOpen) {
      box.put(_currentUserKey, user);
    } else {
      print("Failed to store current user!");
    }
  }

  Future<UserModel?> getCurrentUser() async {
    final box = Hive.box(_currentUserBox);
    if (box.isOpen) {
      final currentUser = await box.get(_currentUserKey);
      return currentUser;
    } else {
      print("Failed to fetch current user!");
    }
    return null;
  }
}
