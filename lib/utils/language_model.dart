import 'dart:ui';

enum Language {
  english(
    Locale('en', 'US'),
    'English',
  ),
  bengali(
    Locale('bn', 'BN'),
    'বাংলা',
  );

  const Language(
    this.value,
    this.text,
  );

  final Locale value;
  final String text;
}
