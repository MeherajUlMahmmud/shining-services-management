import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shining_services_management/cubits/app_theme_cubit.dart';
import 'package:shining_services_management/cubits/auth_cubit.dart';
import 'package:shining_services_management/cubits/language_cubit.dart';
import 'package:shining_services_management/cubits/user_cubit.dart';
import 'package:shining_services_management/models/auth/auth_data.dart';
import 'package:shining_services_management/models/settings/settings.dart';
import 'package:shining_services_management/models/user/user.dart';
import 'package:shining_services_management/repositories/auth/local_auth_repository.dart';
import 'package:shining_services_management/repositories/auth/remote_auth_repository.dart';
import 'package:shining_services_management/repositories/settings/settings_repository.dart';
import 'package:shining_services_management/repositories/user/local_user_repository.dart';
import 'package:shining_services_management/repositories/user/remote_user_repository.dart';
import 'package:shining_services_management/ui/screens/utility/splash_screen.dart';
import 'package:shining_services_management/ui/styles/theme.dart';
import 'package:shining_services_management/utils/constants.dart';

import 'utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and register adapters
  await Hive.initFlutter();
  Hive.registerAdapter(AuthDataAdapter());
  Hive.registerAdapter(SettingsAdapter());
  Hive.registerAdapter(UserAdapter());

  // Open Hive boxes only once
  final authBox = await Hive.openBox<AuthData>('auth');
  final settingsBox = await Hive.openBox<Settings>('settings');
  final Box<User> userBox = await Hive.openBox<User>('user');

  final settingsRepository = SettingsRepository(settingsBox);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppThemeCubit(settingsRepository)),
        BlocProvider(create: (_) => LanguageCubit(settingsRepository)),
        BlocProvider(
          create: (_) => UserCubit(
            RemoteUserRepository(),
            LocalUserRepository(userBox),
          ),
        ),
        BlocProvider(
          create: (context) => AuthCubit(
            RemoteAuthRepository(),
            LocalAuthRepository(authBox),
            BlocProvider.of<UserCubit>(context),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<AppThemeCubit>();

    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        final themeMode = themeCubit.state.selectedAppTheme == AppTheme.dark
            ? ThemeMode.dark
            : ThemeMode.light;

        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: AppConstants.appName,
              theme: createLightTheme(),
              darkTheme: createDarkTheme(),
              themeMode: themeMode,
              locale: Locale(
                  state.selectedLanguage.name == 'Bengali' ? 'bn' : 'en'),
              // Use the current language
              supportedLocales: const [
                Locale('en'), // English
                Locale('bn'), // Bengali
              ],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              onGenerateRoute: generateRoute,
              home: const SplashScreen(),
            );
          },
        );
      },
    );
  }
}
