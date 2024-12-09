import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData createLightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primarySwatch: createMaterialColor(const Color(0xFF532AD6)),
    primaryColor: createMaterialColor(const Color(0xFF532AD6)),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Color(0xFF532AD6),
      centerTitle: true,
      elevation: 2.0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: createMaterialColor(const Color(0xFF532AD6)),
      unselectedItemColor: Colors.grey,
      selectedIconTheme: const IconThemeData(size: 28),
      unselectedIconTheme: const IconThemeData(size: 24),
      showUnselectedLabels: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: Colors.grey,
      suffixIconColor: createMaterialColor(const Color(0xFF532AD6)),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: createMaterialColor(const Color(0xFF532AD6)),
          width: 2.0,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      labelStyle: TextStyle(color: Colors.grey.shade800),
      hintStyle: TextStyle(color: Colors.grey.shade500),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: createMaterialColor(const Color(0xFF532AD6)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: createMaterialColor(const Color(0xFF532AD6)),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 4,
      shadowColor: Colors.grey.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.grey.shade900,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: TextStyle(
        color: Colors.grey.shade700,
        fontSize: 16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}

ThemeData createDarkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primarySwatch: createMaterialColor(const Color(0xFF532AD6)),
    primaryColor: createMaterialColor(const Color(0xFF532AD6)),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF532AD6),
      centerTitle: true,
      elevation: 2.0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF1F1F1F),
      selectedItemColor: createMaterialColor(const Color(0xFF532AD6)),
      unselectedItemColor: Colors.grey.shade400,
      selectedIconTheme: const IconThemeData(size: 28),
      unselectedIconTheme: const IconThemeData(size: 24),
      showUnselectedLabels: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: Colors.grey.shade500,
      suffixIconColor: createMaterialColor(const Color(0xFF532AD6)),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade700),
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade700),
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: createMaterialColor(const Color(0xFF532AD6)),
          width: 2.0,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      labelStyle: TextStyle(color: Colors.grey.shade300),
      hintStyle: TextStyle(color: Colors.grey.shade600),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: createMaterialColor(const Color(0xFF532AD6)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: createMaterialColor(const Color(0xFF532AD6)),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF1E1E1E),
      elevation: 4,
      shadowColor: Colors.black54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: const Color(0xFF1E1E1E),
      titleTextStyle: TextStyle(
        color: Colors.grey.shade200,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: TextStyle(
        color: Colors.grey.shade400,
        fontSize: 16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
