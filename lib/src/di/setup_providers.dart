import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic/src/cubit/theme/theme_cubit.dart';
import 'package:magic/src/repository/shared_preference.dart';

Widget setupProviders(Widget child) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ThemeCubit(
          sharedPreferenceRepo: context.read<SharedPreferenceRepo>(),
        )..decideOnTheme(),
      ),
    ],
    child: child,
  );
}
