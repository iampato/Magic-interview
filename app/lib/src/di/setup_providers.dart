import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic/src/cubit/theme/theme_cubit.dart';
import 'package:magic/src/core/shared_preference.dart';
import 'package:magic/src/features/landing/cubit/authentication/authentication_cubit.dart';

Widget setupProviders(Widget child) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ThemeCubit(
          sharedPreferenceRepo: context.read<SharedPreferenceRepo>(),
        )..decideOnTheme(),
      ),
      BlocProvider(
        create: (context) => AuthenticationCubit(
          preferencesRepo: context.read<SharedPreferenceRepo>(),
        )..isUserLoggedIn(),
      ),
    ],
    child: child,
  );
}
