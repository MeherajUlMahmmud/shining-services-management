import 'package:bloc/bloc.dart';
import 'package:shining_services_management/repositories/settings/settings_repository.dart';

enum AppLanguage { Bengali, English }

class LanguageCubit extends Cubit<LanguageState> {
  final SettingsRepository repository;

  LanguageCubit(this.repository)
      : super(const LanguageState(selectedLanguage: AppLanguage.English)) {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final language = await repository.getLanguage();
    emit(LanguageState(selectedLanguage: language));
  }

  Future<void> setLanguage(AppLanguage language) async {
    await repository.saveLanguage(language);
    emit(LanguageState(selectedLanguage: language));
  }
}

class LanguageState {
  final AppLanguage selectedLanguage;

  const LanguageState({required this.selectedLanguage});
}
