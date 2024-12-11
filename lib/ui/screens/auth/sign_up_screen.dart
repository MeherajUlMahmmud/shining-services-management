import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shining_services_management/ui/widgets/custom_text_field.dart';
import 'package:shining_services_management/utils/constants.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
              AppLocalizations.of(context)!.signUpTitle,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.h),
            Wrap(
              children: [
                Text(
                  AppLocalizations.of(context)!.alreadyHaveAccount,
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
                      AppRoutes.loginScreenRouteName,
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.login,
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
              hintText: AppLocalizations.of(context)!.fullName,
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              hintText:  AppLocalizations.of(context)!.email,
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              hintText: AppLocalizations.of(context)!.password,
              obscureText: true,
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              hintText: AppLocalizations.of(context)!.confirmPassword,
              obscureText: true,
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
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
                child: Text(AppLocalizations.of(context)!.createAccount),
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
                  AppLocalizations.of(context)!.orSignUpVia,
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
            SizedBox(height: 16.h),
            Text.rich(
              TextSpan(
                text: AppLocalizations.of(context)!.agreeToTerms,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(
                    text: AppLocalizations.of(context)!.termsAndConditions,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
