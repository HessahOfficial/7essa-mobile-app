import 'package:hessa/features/auth/data/models/token_model.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';
import 'package:hive/hive.dart';

class HiveHelper {
  final _userBox = "CURRENT_USER";
  final _currentUserKey = "USER";
  final _currentUserTokensKey = "TOKENS";
  final _settingsBox = "SETTINGS";
  final _localeKey = "LOCALE";
  final _themeKey = "THEME";
  final _pinKey = "PIN";
  final _isGoogleAuthKey = "GOOGLE_AUTH";
  final _isFirstLaunchKey = "FIRST_LAUNCH";

  bool? isDark;
  bool? isGoogleAuth;
  bool? isFirstLaunch;
  String? locale;
  UserModel? currentUser;
  TokenModel? token;

  Future<void> initializeBoxes() async {
    try {
      // await deleteBoxes();
      final userBox = await Hive.openBox(_userBox);
      currentUser = userBox.get(_currentUserKey);
      token = userBox.get(_currentUserTokensKey);
      final settingsBox = await Hive.openBox(_settingsBox);
      isDark = settingsBox.get(_themeKey);
      locale = settingsBox.get(_localeKey);
      isFirstLaunch = settingsBox.get(_isFirstLaunchKey);
      isGoogleAuth = settingsBox.get(_isGoogleAuthKey);
      print(" Google Auth: $isGoogleAuth");
    } catch (e) {
      print("hive init error: $e");
    }
  }

  Future<void> deleteBoxes() async {
    await Hive.deleteBoxFromDisk(_userBox);
    await Hive.deleteBoxFromDisk(_settingsBox);
    print("deleted!");
  }

  Future<void> changeTheme({required bool isDark}) async {
    final box = Hive.box(_settingsBox);
    box.put(_themeKey, isDark);
    this.isDark = isDark;
  }

  Future<void> changeLocale({required String locale}) async {
    final box = Hive.box(_settingsBox);
    box.put(_localeKey, locale);
    this.locale = locale;
  }

  Future<void> storeCurrentUser({
    required UserModel? user,
    required TokenModel? tokens,
  }) async {
    final box = Hive.box(_userBox);
    if (box.isOpen) {
      box.put(_currentUserKey, user);
      currentUser = user;
      box.put(_currentUserTokensKey, tokens);
      token = tokens;
    } else {
      print("Failed to store current user!");
    }
  }

  Future<TokenModel?> getTokens() async {
    final box = Hive.box(_userBox);
    if (box.isOpen) {
      final tokens = await box.get(_currentUserTokensKey);
      return tokens;
    } else {
      print("Failed to fetch tokens!");
    }
    return null;
  }

  Future<void> storeIsFirstLaunch({required bool isFirstLaunch}) async {
    final box = Hive.box(_settingsBox);
    if (box.isOpen) {
      box.put(_isFirstLaunchKey, isFirstLaunch);
    } else {
      print("Failed to store isFirstLaunch!");
    }
  }

  Future<void> storePin({required String pin}) async {
    final box = Hive.box(_settingsBox);
    if (box.isOpen) {
      box.put(_pinKey, pin);
    } else {
      print("Failed to store pin!");
    }
  }

  Future<void> storeIsGoogleAuth({required bool? isGoogleAuth}) async {
    final box = Hive.box(_settingsBox);
    if (box.isOpen) {
      box.put(_isGoogleAuthKey, isGoogleAuth);
    } else {
      print("Failed to store isGoogleAuth!");
    }
  }

  Future<UserModel?> getCurrentUser() async {
    final box = Hive.box(_userBox);
    if (box.isOpen) {
      final currentUser = await box.get(_currentUserKey);
      return currentUser;
    } else {
      print("Failed to fetch current user!");
    }
    return null;
  }

  Future<String?> getPin() async {
    final box = Hive.box(_settingsBox);
    if (box.isOpen) {
      final pin = await box.get(_pinKey);
      return pin;
    } else {
      print("Failed to fetch pin!");
    }
    return "";
  }

  Future<bool?> getIsGoogleAuth() async {
    final box = Hive.box(_settingsBox);
    if (box.isOpen) {
      final isGoogleAuth = await box.get(_isGoogleAuthKey);
      return isGoogleAuth;
    } else {
      print("Failed to fetch isGoogleAuth!");
    }
    return false;
  }
}
