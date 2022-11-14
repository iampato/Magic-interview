import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic/src/repository/shared_preference.dart';

setupRepository() {
  return [
    RepositoryProvider(
      create: (context) => SharedPreferenceRepo(),
    ),
  ];
}