part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class LocaleChange extends SettingsState {}

class ThemeChange extends SettingsState {}
