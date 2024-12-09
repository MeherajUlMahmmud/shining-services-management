import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shining_services_management/ui/widgets/custom_text_field.dart';
import 'package:shining_services_management/utils/constants.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = AppRoutes.loginScreenRouteName;

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.settings),
        //     onPressed: () {
        //       Navigator.pushNamed(context, AppRoutes.settingsScreenRouteName);
        //     },
        //   ),
        // ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 52.h),
            Text(
              AppLocalizations.of(context)!.loginTitle,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.h),
            Wrap(
              children: [
                Text(
                  AppLocalizations.of(context)!.dontHaveAccount,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(
                      context,
                      AppRoutes.signUpScreenRouteName,
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.signUp,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            CustomTextFormField(
              hintText: AppLocalizations.of(context)!.email,
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              hintText: AppLocalizations.of(context)!.password,
              obscureText: true,
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(
                    context,
                    AppRoutes.mainScreenRouteName,
                  );
                },
                style: ButtonStyle(
                  side: WidgetStateProperty.all(
                    const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  textStyle: WidgetStateProperty.all(
                    TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                child: Text(AppLocalizations.of(context)!.login),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Row(
              children: [
                const Expanded(child: Divider()),
                SizedBox(
                  width: 16.w,
                ),
                Text(
                  AppLocalizations.of(context)!.orLoginVia,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 16.w),
                const Expanded(child: Divider()),
              ],
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  side: WidgetStateProperty.all(
                      const BorderSide(color: Colors.grey)),
                  padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(vertical: 14.h)),
                  textStyle: WidgetStateProperty.all(
                    TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Image.asset("assets/Google.png"),
                    SizedBox(width: 10.w),
                    Text(AppLocalizations.of(context)!.google),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
