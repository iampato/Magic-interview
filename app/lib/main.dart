import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic/src/di/setup_providers.dart';
import 'package:magic/src/di/setup_repository.dart';
import 'package:magic/src/core/cubit_observer.dart';
import 'package:magic/src/app/material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // HydratedCubit.storage = await HydratedStorage.build();
  Bloc.observer = MyBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(
    MultiRepositoryProvider(
      providers: setupRepository(),
      child: setupProviders(
        const MyApp(),
      ),
    ),
  );
}
