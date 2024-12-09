import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shining_services_management/cubits/auth_cubit.dart';
import 'package:shining_services_management/ui/screens/auth/login_screen.dart';
import 'package:shining_services_management/ui/screens/main/main_screen.dart';
import 'package:shining_services_management/utils/app_logger.dart';
import 'package:shining_services_management/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = AppRoutes.splashScreenRouteName;

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    AppLogger().info("SplashScreen initialized.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthCubit, AuthState>(
          listenWhen: (previous, current) {
            // Log state transitions for tracking
            AppLogger().debug(
                "SplashScreen - Auth status changed from ${previous.status} to ${current.status}");
            return previous.status == AuthStatus.loading &&
                current.status != AuthStatus.loading;
          },
          listener: (context, state) {
            if (state.status == AuthStatus.authenticated) {
              AppLogger()
                  .info("User authenticated - navigating to MainScreen.");
              Navigator.pushReplacementNamed(context, MainScreen.routeName);
            } else if (state.status == AuthStatus.unauthenticated ||
                state.status == AuthStatus.error) {
              AppLogger().warn(
                  "User unauthenticated or error occurred - navigating to LoginScreen.");
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            }
          },
          builder: (context, state) {
            if (state.status == AuthStatus.loading) {
              return const CircularProgressIndicator();
            }
            return Text(
              AppConstants.appName,
              style: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
