import 'package:flutter/material.dart';
import 'package:shining_services_management/ui/screens/auth/login_screen.dart';
import 'package:shining_services_management/ui/screens/auth/sign_up_screen.dart';
import 'package:shining_services_management/ui/screens/main/main_screen.dart';
import 'package:shining_services_management/ui/screens/utility/not_found_screen.dart';
import 'package:shining_services_management/ui/screens/utility/settings_screen.dart';
import 'package:shining_services_management/ui/screens/utility/splash_screen.dart';
import 'package:shining_services_management/utils/constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splashScreenRouteName:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    case AppRoutes.loginScreenRouteName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case AppRoutes.signUpScreenRouteName:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());
    case AppRoutes.mainScreenRouteName:
      return MaterialPageRoute(builder: (context) => const MainScreen());
    case AppRoutes.settingsScreenRouteName:
      return MaterialPageRoute(builder: (context) => const SettingsScreen());
    default:
      return MaterialPageRoute(builder: (context) => const NotFoundScreen());
  }
}
