import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shining_services_management/cubits/auth_cubit.dart';
import 'package:shining_services_management/models/api/auth_api_request.dart';
import 'package:shining_services_management/ui/widgets/custom_text_field.dart';
import 'package:shining_services_management/utils/constants.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  SignUpForm({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final password1Controller = TextEditingController();
    final password2Controller = TextEditingController();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.loading) {
          showDialog(
            context: context,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state.status == AuthStatus.authenticated) {
          Navigator.pop(context); // Close loading dialog
          Navigator.popAndPushNamed(context, AppRoutes.loginScreenRouteName);
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
                AppLocalizations.of(context)!.signUp,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 24.h),
              CustomTextFormField(
                hintText: AppLocalizations.of(context)!.firstName,
                controller: firstNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.firstNameRequired;
                  } else if (value.length < 2) {
                    return AppLocalizations.of(context)!.firstNameTooShort;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                hintText: AppLocalizations.of(context)!.lastName,
                controller: lastNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.lastNameRequired;
                  } else if (value.length < 2) {
                    return AppLocalizations.of(context)!.lastNameTooShort;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                hintText: AppLocalizations.of(context)!.username,
                controller: usernameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.usernameRequired;
                  } else if (value.length < 4) {
                    return AppLocalizations.of(context)!.usernameTooShort;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                hintText: AppLocalizations.of(context)!.email,
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.emailRequired;
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return AppLocalizations.of(context)!.emailInvalid;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                hintText: AppLocalizations.of(context)!.password,
                controller: password1Controller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.passwordRequired;
                  } else if (value.length < 8) {
                    return AppLocalizations.of(context)!.passwordTooShort;
                  }
                  return null;
                },
                obscureText: true,
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                hintText: AppLocalizations.of(context)!.confirmPassword,
                controller: password2Controller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!
                        .confirmPasswordRequired;
                  } else if (value != password1Controller.text) {
                    return AppLocalizations.of(context)!.passwordsDoNotMatch;
                  }
                  return null;
                },
                obscureText: true,
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    RegisterRequest registerRequestData = RegisterRequest(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      username: usernameController.text,
                      email: emailController.text,
                      password1: password1Controller.text,
                      password2: password2Controller.text,
                    );
                    context.read<AuthCubit>().registerUser(
                          registerRequestData,
                        );
                  }
                },
                child: Text(AppLocalizations.of(context)!.signUp),
              ),
            ],
          ),
        );
      },
    );
  }
}
