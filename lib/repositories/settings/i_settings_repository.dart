import 'package:shining_services_management/cubits/app_theme_cubit.dart';
import 'package:shining_services_management/cubits/language_cubit.dart';

abstract class ISettingsRepository {
  Future<void> saveThemeMode(AppTheme themeMode);

  Future<AppTheme> getThemeMode();

  Future<void> saveLanguage(AppLanguage language);

  Future<AppLanguage> getLanguage();

  Future<void> clearSettings();

// Add any additional methods for remote or local updates
}
