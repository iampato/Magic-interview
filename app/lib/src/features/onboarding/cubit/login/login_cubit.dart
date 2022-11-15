import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:magic/src/core/shared_preference.dart';
import 'package:magic/src/features/onboarding/models/login_response.dart';
import 'package:magic/src/features/onboarding/repository/login_repository.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final SharedPreferenceRepo preferencesRepo;
  final LoginRepository loginRepo;
  LoginCubit({
    required this.preferencesRepo,
    required this.loginRepo,
  }) : super(const LoginState.initial());
  // events
  Future<void> loginUser({
    required String emailAddress,
    required String password,
  }) async {
    try {
      emit(const LoginState.loading());
      final response = await loginRepo.login(
        emailAddress: emailAddress,
        password: password,
      );
      if (response != null) {
        emit(LoginState.success(response: response));
      } else {
        emit(const LoginState.error(message: "An error occured"));
      }
    } catch (e, _) {
      if (e is DioError) {
        Logger().d(e.response?.data);
        Logger().d(e.requestOptions.uri.toString());
        if (e.type == DioErrorType.connectTimeout ||
            e.type == DioErrorType.other) {
          emit(const LoginState.error(
              message: "Check your internet connection"));
        } else if (e.response?.statusCode == 400) {
          Logger().e(e.requestOptions.uri);
          Logger().e(e.requestOptions.method);
          Logger().e(e.requestOptions.data);
          emit(
            LoginState.error(message: e.response?.data),
          );
        } else if (e.response?.statusCode == 401) {
          emit(
            LoginState.error(message: e.response?.data),
          );
        } else if (e.response?.statusCode == 500) {
          final message = e.response?.data['message'];
          emit(
            LoginState.error(message: message),
          );
        } else {
          Logger().e(e.toString());
          emit(const LoginState.error(message: "An error occured"));
        }
      } else {
        emit(LoginState.error(message: e.toString()));
      }
    }
  }
}
