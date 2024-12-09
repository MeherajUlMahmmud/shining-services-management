import 'package:flutter/material.dart';
import 'package:shining_services_management/ui/screens/auth/login_screen.dart';
import 'package:shining_services_management/ui/screens/auth/sign_up_screen.dart';
import 'package:shining_services_management/ui/screens/main/main_screen.dart';
import 'package:shining_services_management/ui/screens/utility/not_found_screen.dart';
import 'package:shining_services_management/ui/screens/utility/settings_screen.dart';
import 'package:shining_services_management/ui/screens/utility/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());
    case MainScreen.routeName:
      return MaterialPageRoute(builder: (context) => const MainScreen());
    case SettingsScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SettingsScreen());
    default:
      return MaterialPageRoute(builder: (context) => const NotFoundScreen());
  }
}
