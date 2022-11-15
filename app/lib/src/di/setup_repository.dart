import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic/src/core/shared_preference.dart';
import 'package:magic/src/features/onboarding/repository/login_repository.dart';

setupRepository() {
  return [
    RepositoryProvider(
      create: (context) => SharedPreferenceRepo(),
    ),
    RepositoryProvider(
      create: (context) => LoginRepository(),
    ),
  ];
}
