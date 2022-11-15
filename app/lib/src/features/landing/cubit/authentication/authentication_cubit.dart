import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magic/src/core/shared_preference.dart';
import 'package:magic/src/features/landing/models/user_model.dart';

part 'authentication_state.dart';
part 'authentication_cubit.freezed.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final SharedPreferenceRepo preferencesRepo;
  AuthenticationCubit({
    required this.preferencesRepo,
  }) : super(const AuthenticationState.initial());

  // isUserLoggedIn
  // requires no parameters
  Future<void> isUserLoggedIn() async {
    try {
      String? userStr = await preferencesRepo.getUserValue();
      if (userStr == null) {
        // new user
        emit(const AuthenticationState.unAuthenticated());
      } else {
        final userMap = jsonDecode(userStr);
        final userResponse = UserModel.fromJson(userMap);
        emit(AuthenticationState.authenticated(
          userModel: userResponse,
        ));
      }
    } catch (e) {
      emit(const AuthenticationState.unAuthenticated());
    }
  }

  // authenticateUser
  // requires LoginResponse
  Future<void> authenticateUser(UserModel response) async {
    try {
      // save user to shared preference
      await preferencesRepo.saveUserValue(jsonEncode(response.toJson()));
      emit(AuthenticationState.authenticated(
        userModel: response,
      ));
    } catch (e) {
      emit(const AuthenticationState.unAuthenticated());
    }
  }

  // logOut
  // requires no params
  Future<void> logOut() async {
    try {
      await preferencesRepo.destory();
      emit(const AuthenticationState.unAuthenticated());
    } catch (e) {
      emit(const AuthenticationState.unAuthenticated());
    }
  }

  UserModel? get user => state.maybeWhen(
        authenticated: (userModel) => userModel,
        orElse: () => null,
      );
}
