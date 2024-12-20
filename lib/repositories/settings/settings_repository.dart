import 'package:hive/hive.dart';
import 'package:shining_services_management/cubits/app_theme_cubit.dart';
import 'package:shining_services_management/cubits/language_cubit.dart';
import 'package:shining_services_management/data_sources/local_data_source.dart';
import 'package:shining_services_management/models/settings/settings.dart';

import 'i_settings_repository.dart';

class SettingsRepository implements ISettingsRepository {
  final HiveStorageService<Settings> _localStorage;

  SettingsRepository(Box<Settings> settingsBox)
      : _localStorage = HiveStorageService<Settings>.fromBox(settingsBox);

  // Save theme mode locally
  @override
  Future<void> saveThemeMode(AppTheme theme) async {
    final currentSettings = _localStorage.loadItem('userSettings',
        defaultValue: Settings(language: 'en', isDarkMode: false));
    final updatedSettings =
        currentSettings?.copyWith(isDarkMode: theme == AppTheme.dark);
    await _localStorage.saveItem('userSettings', updatedSettings!);
  }

  // Get theme mode from local storage
  @override
  Future<AppTheme> getThemeMode() async {
    final settings = _localStorage.loadItem('userSettings');
    return settings != null && settings.isDarkMode
        ? AppTheme.dark
        : AppTheme.light;
  }

  // Save language locally
  @override
  Future<void> saveLanguage(AppLanguage language) async {
    final currentSettings = _localStorage.loadItem('userSettings',
        defaultValue: Settings(language: 'en', isDarkMode: false));
    final updatedSettings = currentSettings?.copyWith(
        language: language == AppLanguage.Bengali ? 'bn' : 'en');
    await _localStorage.saveItem('userSettings', updatedSettings!);
  }

  // Get language from local storage
  @override
  Future<AppLanguage> getLanguage() async {
    final settings = _localStorage.loadItem('userSettings');
    return settings?.language == 'bn'
        ? AppLanguage.Bengali
        : AppLanguage.English;
  }

  // Clear settings locally
  @override
  Future<void> clearSettings() async {
    await _localStorage.clearAllItems();
  }
}
