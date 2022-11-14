import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic/src/core/shared_preference.dart';

setupRepository() {
  return [
    RepositoryProvider(
      create: (context) => SharedPreferenceRepo(),
    ),
  ];
}