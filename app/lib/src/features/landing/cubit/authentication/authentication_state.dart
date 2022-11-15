part of 'authentication_cubit.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = _Initial;
  const factory AuthenticationState.authenticated({
    UserModel? userModel,
  }) = _Authenticated;
  const factory AuthenticationState.unAuthenticated() = _Unauthenticated;
}
