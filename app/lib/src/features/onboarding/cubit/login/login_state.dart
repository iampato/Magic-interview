part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.success({
    required LoginResponse response,
  }) = _Success;
  const factory LoginState.error({
    required String message,
  }) = _Error;
}
