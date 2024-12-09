import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shining_services_management/models/api/api_response.dart';
import 'package:shining_services_management/models/user/user.dart';
import 'package:shining_services_management/repositories/user/i_local_user_repository.dart';
import 'package:shining_services_management/repositories/user/i_remote_user_repository.dart';
import 'package:shining_services_management/utils/app_logger.dart';
import 'package:shining_services_management/utils/constants.dart';

class UserCubit extends Cubit<UserState> {
  final IRemoteUserRepository remoteUserRepository;
  final ILocalUserRepository localUserRepository;

  UserCubit(
    this.remoteUserRepository,
    this.localUserRepository,
  ) : super(const UserState(
          isLoading: false,
          isError: false,
        ));

  // Fetch user profile from remote
  Future<void> fetchUserProfile(String accessToken) async {
    AppLogger().info("Starting fetchUserProfile");

    try {
      emit(state.copyWith(isLoading: true, isError: false));

      final ApiResponse response =
          await remoteUserRepository.fetchUserProfile(accessToken);

      if (response.status == HTTPStatus.httpOkCode) {
        final User user = User.fromJson(response.data);

        await localUserRepository.saveUser(user);

        emit(state.copyWith(
          isLoading: false,
          isError: false,
          currentUser: user,
        ));

        AppLogger().info("User profile fetched and saved locally.");
      } else {
        emit(state.copyWith(
          isLoading: false,
          isError: true,
          errorMessage: response.error,
        ));

        AppLogger().warn("Fetch user profile failed: ${response.error}");
      }
    } catch (e, stackTrace) {
      AppLogger().error("Error during fetchUserProfile",
          error: e, stackTrace: stackTrace);

      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: e.toString(),
      ));
    }
  }

  // Update user details remotely
  Future<void> updateUser(
      String accessToken, int userId, Map<String, dynamic> updateData) async {
    AppLogger().info("Starting updateUser for userId: $userId");

    try {
      emit(state.copyWith(isLoading: true, isError: false));

      final ApiResponse response = await remoteUserRepository.updateUser(
          accessToken, userId, updateData);

      if (response.status == HTTPStatus.httpOkCode) {
        emit(state.copyWith(isLoading: false, isError: false));
        AppLogger().info("User updated successfully.");
      } else {
        emit(state.copyWith(
          isLoading: false,
          isError: true,
          errorMessage: response.error,
        ));
        AppLogger().warn("Update user failed: ${response.error}");
      }
    } catch (e, stackTrace) {
      AppLogger()
          .error("Error during updateUser", error: e, stackTrace: stackTrace);

      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: e.toString(),
      ));
    }
  }

  // Save user data to local storage
  Future<void> saveUserToLocal(User user) async {
    try {
      AppLogger().info("Saving user to local storage.");

      // Save the user data into local storage using the local repository
      await localUserRepository.saveUser(user);

      // Emit a state update with the current user set
      emit(state.copyWith(
        isLoading: false,
        isError: false,
        currentUser: user,
      ));

      AppLogger().info("User saved to local storage successfully.");
    } catch (e, stackTrace) {
      AppLogger().error("Error saving user to local storage",
          error: e, stackTrace: stackTrace);

      // Emit an error state in case of failure
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: e.toString(),
      ));
    }
  }

  // Fetch user details locally
  Future<void> getUserFromLocal() async {
    AppLogger().info("Fetching user from local storage");

    try {
      emit(state.copyWith(isLoading: true, isError: false));

      final User? user = await localUserRepository.getUser();

      if (user != null) {
        emit(state.copyWith(
          isLoading: false,
          isError: false,
          currentUser: user,
        ));

        AppLogger().info("User fetched successfully from local storage.");
      } else {
        emit(state.copyWith(
          isLoading: false,
          isError: true,
          errorMessage: "No user found in local storage.",
        ));

        AppLogger().warn("No user data found in local storage.");
      }
    } catch (e, stackTrace) {
      AppLogger().error("Error during local user fetch",
          error: e, stackTrace: stackTrace);

      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: e.toString(),
      ));
    }
  }

  // Clear user data locally
  Future<void> clearLocalUser() async {
    AppLogger().info("Clearing local user data");

    try {
      await localUserRepository.clearUser();
      emit(state.copyWith(currentUser: null));
      AppLogger().info("Local user data cleared successfully.");
    } catch (e, stackTrace) {
      AppLogger().error("Error during clearing local user data",
          error: e, stackTrace: stackTrace);
    }
  }
}

class UserState {
  final bool isLoading;
  final bool isError;
  final User? currentUser;
  final String? errorMessage;

  const UserState({
    required this.isLoading,
    required this.isError,
    this.currentUser,
    this.errorMessage,
  });

  UserState copyWith({
    bool? isLoading,
    bool? isError,
    User? currentUser,
    String? errorMessage,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      currentUser: currentUser ?? this.currentUser,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
