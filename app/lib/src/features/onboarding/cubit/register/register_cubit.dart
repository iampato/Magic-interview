import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magic/src/features/landing/models/user_model.dart';
import 'package:magic/src/features/onboarding/repository/login_repository.dart';

part 'register_state.dart';
part 'register_cubit.freezed.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final LoginRepository loginRepo;
  RegisterCubit({
    required this.loginRepo,
  }) : super(const RegisterState.initial());
  // events
  Future<void> registerUser({
    required String name,
    required String emailAddress,
    required String password,
  }) async {
    try {
      emit(const RegisterState.loading());
      final response = await loginRepo.register(
        emailAddress: emailAddress,
        password: password,
        name: name,
      );
      if (response != null) {
        emit(RegisterState.success(response: response));
      } else {
        emit(const RegisterState.error(message: "An error occured"));
      }
    } catch (e, _) {
      if (e is DioError) {
        if (e.type == DioErrorType.connectTimeout ||
            e.type == DioErrorType.other) {
          emit(const RegisterState.error(
              message: "Check your internet connection"));
        } else if (e.response?.statusCode == 400) {
          emit(
            RegisterState.error(message: e.response?.data),
          );
        } else if (e.response?.statusCode == 401) {
          emit(
            RegisterState.error(message: e.response?.data),
          );
        } else if (e.response?.statusCode == 500) {
          final message = e.response?.data['message'];
          emit(
            RegisterState.error(message: message),
          );
        } else {
          emit(const RegisterState.error(message: "An error occured"));
        }
      } else {
        emit(RegisterState.error(message: e.toString()));
      }
    }
  }
}
