import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic/src/features/onboarding/cubit/login/login_cubit.dart';
import 'package:magic/src/features/onboarding/repository/login_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../network/model_mock.dart';
import '../repository/login_repository_mocks.dart';
import '../repository/shared_preference_mock.dart';

void main() {
  late LoginCubit cubit;
  late LoginRepository loginRepo;
  late MockSharedPreferenceRepo preferencesRepo;
  setUp(() {
    loginRepo = MockLoginRepository();
    preferencesRepo = MockSharedPreferenceRepo();
    cubit = LoginCubit(
      loginRepo: loginRepo,
      preferencesRepo: preferencesRepo,
    );
  });

  group('LoginCubit', () {
    test('initial state is LoginState.initial()', () {
      expect(cubit.state, equals(const LoginState.initial()));
    });

    /// test login with valid credentials

    blocTest<LoginCubit, LoginState>(
      'emits [loading, success] when login is successful',
      build: () {
        when(() => loginRepo.login(
              emailAddress: any(named: 'emailAddress'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => mockedLoginResponse);
        return cubit;
      },
      act: (cubit) => cubit.loginUser(
        emailAddress: 'muser@example.com',
        password: '12345',
      ),
      expect: () => [
        const LoginState.loading(),
        LoginState.success(response: mockedLoginResponse),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [LoginState.loading(), LoginState.error()] when login is unsuccessful',
      build: () {
        when(() => loginRepo.login(
              emailAddress: any(named: 'emailAddress'),
              password: any(named: 'password'),
            )).thenAnswer((_) => Future.value(null));
        return cubit;
      },
      act: (cubit) async {
        await cubit.loginUser(
          emailAddress: '',
          password: '',
        );
      },
      expect: () => [
        const LoginState.loading(),
        const LoginState.error(message: 'An error occured'),
      ],
    );
  });
}
