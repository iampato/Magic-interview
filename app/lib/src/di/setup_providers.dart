import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic/src/cubit/theme/theme_cubit.dart';
import 'package:magic/src/core/shared_preference.dart';
import 'package:magic/src/features/landing/cubit/authentication/authentication_cubit.dart';
import 'package:magic/src/features/onboarding/cubit/login/login_cubit.dart';
import 'package:magic/src/features/onboarding/cubit/register/register_cubit.dart';
import 'package:magic/src/features/onboarding/repository/login_repository.dart';

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
      BlocProvider(
        create: (context) => LoginCubit(
          preferencesRepo: context.read<SharedPreferenceRepo>(),
          loginRepo: context.read<LoginRepository>(),
        ),
      ),
      BlocProvider(
        create: (context) => RegisterCubit(
          loginRepo: context.read<LoginRepository>(),
        ),
      ),
    ],
    child: child,
  );
}
