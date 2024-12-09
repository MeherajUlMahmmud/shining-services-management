import 'package:hive/hive.dart';

part 'settings.g.dart'; // This part directive will be used for code generation

@HiveType(typeId: 1) // Unique typeId for this class
class Settings {
  @HiveField(0)
  final String language; // Language code, e.g., "en" or "bn"

  @HiveField(1)
  final bool isDarkMode; // true for dark mode, false for light mode

  Settings({required this.language, required this.isDarkMode});

  // Optional: Convenience method to toggle theme
  Settings copyWith({String? language, bool? isDarkMode}) {
    return Settings(
      language: language ?? this.language,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
