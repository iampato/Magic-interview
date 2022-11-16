// mock LoginRepository
import 'package:magic/src/features/onboarding/repository/login_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../network/model_mock.dart';

class MockLoginRepository extends Mock implements LoginRepository {
  MockLoginRepository() {
    // when login
    when(() {
      return login(
        emailAddress: any(named: 'emailAddress'),
        password: any(named: 'password'),
      );
    }).thenAnswer((_) async => mockedLoginResponse);

    // when register
    when(() => register(
          emailAddress: any(named: 'emailAddress'),
          name: any(named: 'name'),
          password: any(named: 'password'),
        )).thenAnswer((_) async => mockedUser);
  }
}
