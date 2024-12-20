import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shining_services_management/repositories/settings/settings_repository.dart';

enum AppTheme { light, dark }

class AppThemeCubit extends Cubit<AppThemeState> {
  final SettingsRepository repository;

  AppThemeCubit(this.repository)
      : super(const AppThemeState(selectedAppTheme: AppTheme.light)) {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final themeMode = await repository.getThemeMode();
    emit(AppThemeState(selectedAppTheme: themeMode));
  }

  // This method will toggle the theme
  void setTheme(AppTheme theme) async {
    await repository.saveThemeMode(theme);
    emit(AppThemeState(selectedAppTheme: theme));
  }
}

class AppThemeState {
  final AppTheme selectedAppTheme;

  const AppThemeState({required this.selectedAppTheme});
}
