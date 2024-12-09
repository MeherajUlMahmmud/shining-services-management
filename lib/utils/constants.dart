class AppConstants {
  static const String appName = 'Shining Services';
  static const String appVersion = '1.0.0';
  static const String appUrl = 'https://flutterchat.com';
  static const String appSupportEmail = '';
  static const String appContactNumber = '+1234567890';
}

class Assets {
  static const String defaultAvatarPath = 'assets/avatars/rdj.png';
}

class AppRoutes {
  static const String splashScreenRouteName = '/';
  static const String loginScreenRouteName = '/login-screen';
  static const String signUpScreenRouteName = '/signup-screen';
  static const String otpScreenRouteName = '/otp-screen';
  static const String forgotPasswordScreenRouteName = '/forgot-password';

  static const String mainScreenRouteName = '/main_screen';
  static const String homeScreenRouteName = '/home_screen';
  static const String resumePreviewScreenRouteName = '/resume-preview';
  static const String profileScreenRouteName = '/profile-screen';
  static const String updateProfileScreenRouteName = '/update-profile';
  static const String settingsScreenRouteName = '/settings';
  static const String accountSettingsScreenRouteName = '/account-settings';
  static const String emailUpdateScreenRouteName = '/email-update';
  static const String notFoundScreenRouteName = '/not-found';
}

class ApiUrl {
  // static const String kBaseUrl = "http://192.168.0.104:8000/api/";
  // static const String kBaseUrl = "http://10.0.2.2:8000/api/";
  // static const String kBaseUrl =
  //     'http://127.0.0.1:8000/api/'; // for iOS simulator
  static const String kBaseUrl = 'https://api.shiningservices.com.au/api/';

  // static const String kBaseUrl =
  //     'https://fantasyleague-backend.onrender.com/api/';

  // Auth
  static const String kAuthUrl = '${kBaseUrl}auth/';
  static const String kLoginUrl = '${kAuthUrl}login/';
  static const String kRegisterUrl = '${kAuthUrl}register/';
  static const String kRefreshTokenUrl = '${kAuthUrl}refresh/';

  // User
  static const String kUserUrl = '${kBaseUrl}user/';

  // Season
  static const String kSeasonUrl = '${kBaseUrl}season';

  // League
  static const String kLeagueUrl = '${kBaseUrl}league/';

  // Fixture
  static const String kFixtureUrl = '${kBaseUrl}fixture/';

  // Team
  static const String kTeamUrl = '${kBaseUrl}team/';
}

class HTTPStatus {
  static const int httpOkCode = 200;
  static const int httpCreatedCode = 201;
  static const int httpNoContentCode = 204;
  static const int httpBadRequestCode = 400;
  static const int httpUnauthorizedCode = 401;
  static const int httpForbiddenCode = 403;
  static const int httpNotFoundCode = 404;
  static const int httpInternalServerErrorCode = 500;
}

class ErrorMessages {
  static const String dataUpdatedMsg = 'Data updated successfully';
  static const String sessionExpiredMsg = 'Session expired, please login again';
  static const String genericErrorMsg =
      'Unable to process your request, please try again later';
}
