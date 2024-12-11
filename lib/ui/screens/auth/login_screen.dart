import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shining_services_management/cubits/auth_cubit.dart';
import 'package:shining_services_management/models/api/auth_api_request.dart';
import 'package:shining_services_management/ui/widgets/custom_text_field.dart';
import 'package:shining_services_management/utils/constants.dart';

class LoginScreen extends StatelessWidget {
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
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.loading) {
          showDialog(
            context: context,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state.status == AuthStatus.authenticated) {
          Navigator.pop(context); // Close loading dialog
          Navigator.popAndPushNamed(context, AppRoutes.mainScreenRouteName);
        } else if (state.status == AuthStatus.error) {
          Navigator.pop(context); // Close loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'An error occurred')),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
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
                controller: usernameController,
                hintText: AppLocalizations.of(context)!.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                controller: passwordController,
                hintText: AppLocalizations.of(context)!.password,
                obscureText: !state.isPasswordVisible,
                // suffixIcon: IconButton(
                //   icon: Icon(state.isPasswordVisible
                //       ? Icons.visibility
                //       : Icons.visibility_off),
                //   onPressed: () {
                //     context.read<AuthCubit>().togglePasswordVisibility();
                //   },
                // ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthCubit>().signIn(LoginRequest(
                            username: usernameController.text,
                            password: passwordController.text,
                          ));
                    }
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
              SizedBox(height: 16.h),
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
        );
      },
    );
  }
}
