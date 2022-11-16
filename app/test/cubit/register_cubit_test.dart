import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic/src/features/onboarding/cubit/register/register_cubit.dart';
import 'package:magic/src/features/onboarding/repository/login_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../network/model_mock.dart';
import '../repository/login_repository_mocks.dart';

void main() {
  late RegisterCubit cubit;
  late LoginRepository loginRepo;
  setUp(() {
    loginRepo = MockLoginRepository();
    cubit = RegisterCubit(
      loginRepo: loginRepo,
    );
  });

  group('RegisterCubit', () {
    test('initial state is RegisterState.initial()', () {
      expect(cubit.state, equals(const RegisterState.initial()));
    });

    /// test register with valid credentials

    blocTest<RegisterCubit, RegisterState>(
      'emits [loading, success] when register is successful',
      build: () {
        when(() => loginRepo.register(
              emailAddress: any(named: 'emailAddress'),
              password: any(named: 'password'),
              name: any(named: 'password'),
            )).thenAnswer((_) async => mockedUser);
        return cubit;
      },
      act: (cubit) => cubit.registerUser(
        emailAddress: 'emailAddress',
        password: 'password',
        name: 'password',
      ),
      expect: () => [
        const RegisterState.loading(),
        RegisterState.success(response: mockedUser),
      ],
    );

    /// test register with invalid credentials
    blocTest<RegisterCubit, RegisterState>(
      'emits [RegisterState.loading(), RegisterState.error()] when register is unsuccessful',
      build: () {
        when(() => loginRepo.register(
              name: any(named: 'name'),
              emailAddress: any(named: 'emailAddress'),
              password: any(named: 'password'),
            )).thenAnswer((_) => Future.value(null));
        return cubit;
      },
      act: (cubit) async {
        await cubit.registerUser(
          name: 'name',
          emailAddress: 'emailAddress',
          password: 'password',
        );
      },
      expect: () => [
        const RegisterState.loading(),
        const RegisterState.error(message: 'An error occured'),
      ],
    );

    /// test register with empty credentials
    /// test register with invalid email
    /// test register with invalid password
  });
}
