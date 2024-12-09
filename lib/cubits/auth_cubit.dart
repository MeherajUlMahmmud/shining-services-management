import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shining_services_management/cubits/user_cubit.dart';
import 'package:shining_services_management/models/api/api_response.dart';
import 'package:shining_services_management/models/api/auth_api_request.dart';
import 'package:shining_services_management/models/api/login_user_response.dart';
import 'package:shining_services_management/models/auth/auth_data.dart';
import 'package:shining_services_management/repositories/auth/i_local_auth_repository.dart';
import 'package:shining_services_management/repositories/auth/i_remote_auth_repository.dart';
import 'package:shining_services_management/utils/app_logger.dart';
import 'package:shining_services_management/utils/constants.dart';
import 'package:shining_services_management/utils/helper.dart';

enum AuthStatus { authenticated, unauthenticated, loading, error }

class AuthCubit extends Cubit<AuthState> {
  final IRemoteAuthRepository remoteAuthRepository;
  final ILocalAuthRepository localAuthRepository;
  final UserCubit userCubit;

  AuthCubit(
    this.remoteAuthRepository,
    this.localAuthRepository,
    this.userCubit,
  ) : super(const AuthState(
          status: AuthStatus.loading,
          isPasswordVisible: false,
          accessToken: null,
        )) {
    checkAuthentication();
  }

  Future<void> checkAuthentication() async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      AppLogger().info("Starting authentication check...");

      final accessToken = await localAuthRepository.getAccessToken();
      AppLogger().debug("Access token retrieved: $accessToken");

      if (!Helper().isNullEmptyOrFalse(accessToken)) {
        AppLogger().info("User is authenticated.");
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          accessToken: accessToken,
        ));
      } else {
        AppLogger().warn("User is unauthenticated. No access token found.");
        emit(state.copyWith(
          status: AuthStatus.unauthenticated,
          accessToken: null,
        ));
      }
    } catch (e, stackTrace) {
      AppLogger().error("Error during authentication check",
          error: e, stackTrace: stackTrace);
      emit(state.copyWith(
        status: AuthStatus.error,
        accessToken: null,
        errorMessage: e.toString(),
      ));
    }
  }

  void togglePasswordVisibility() {
    final isNowVisible = !state.isPasswordVisible;
    AppLogger().info("Toggling password visibility to: $isNowVisible");
    emit(state.copyWith(isPasswordVisible: isNowVisible));
  }

  Future<void> registerUser(RegisterRequest registerRequestData) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      AppLogger()
          .info("Attempting user registration with data: $registerRequestData");

      final ApiResponse response =
          await remoteAuthRepository.registerUser(registerRequestData);
      AppLogger().info("Registration response status: ${response.status}");

      if (response.status == HTTPStatus.httpOkCode) {
        AppLogger().info("Registration successful. Parsing response.");
        final loginResponse = LoginResponse.fromJson(response.data);

        await localAuthRepository.saveAuthData(
          AuthData(
            accessToken: loginResponse.tokens.access,
            refreshToken: loginResponse.tokens.refresh,
          ),
        );
        AppLogger().info("Tokens saved locally. User authenticated.");

        emit(state.copyWith(
          status: AuthStatus.authenticated,
          accessToken: loginResponse.tokens.access,
        ));
      } else {
        AppLogger().warn("Registration failed with status ${response.status}");
        emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: "Registration failed",
        ));
      }
    } catch (e, stackTrace) {
      AppLogger().error("Error during user registration",
          error: e, stackTrace: stackTrace);
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> signIn(LoginRequest loginRequestData) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      AppLogger()
          .info("Starting user sign-in with email: ${loginRequestData.email}");

      final ApiResponse response =
          await remoteAuthRepository.loginUser(loginRequestData);
      AppLogger().info("Sign-in response status: ${response.status}");

      if (response.status == HTTPStatus.httpOkCode) {
        AppLogger().info("Sign-in successful. Parsing tokens.");
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);

        await localAuthRepository.saveAuthData(
          AuthData(
            accessToken: loginResponse.tokens.access,
            refreshToken: loginResponse.tokens.refresh,
          ),
        );

        AppLogger().info("Tokens saved locally. User authenticated.");

        await userCubit
            .saveUserToLocal(loginResponse.user); // Call UserCubit method

        emit(state.copyWith(
          status: AuthStatus.authenticated,
          accessToken: loginResponse.tokens.access,
        ));
      } else {
        AppLogger().warn(
            "Sign-in failed with status ${response.status}. Invalid credentials.");
        emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: "Invalid credentials",
        ));
      }
    } catch (e, stackTrace) {
      AppLogger()
          .error("Error during sign-in", error: e, stackTrace: stackTrace);
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> signOut() async {
    try {
      AppLogger().info("Starting user sign-out.");
      await localAuthRepository.clearAuthData();
      AppLogger()
          .info("Auth data cleared from local storage. User signed out.");

      emit(state.copyWith(status: AuthStatus.unauthenticated));
    } catch (e, stackTrace) {
      AppLogger()
          .error("Error during sign-out", error: e, stackTrace: stackTrace);
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}

class AuthState {
  final AuthStatus status;
  final bool isPasswordVisible;
  final String? accessToken;
  final String? errorMessage;

  const AuthState({
    required this.status,
    required this.isPasswordVisible,
    this.accessToken,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    bool? isPasswordVisible,
    String? accessToken,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      accessToken: accessToken,
      errorMessage: errorMessage,
    );
  }
}
