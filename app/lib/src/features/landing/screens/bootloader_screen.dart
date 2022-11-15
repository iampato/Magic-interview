import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:magic/src/core/core.dart';

import '../cubit/authentication/authentication_cubit.dart';

class BootloaderScreen extends StatefulWidget {
  const BootloaderScreen({Key? key}) : super(key: key);

  @override
  State<BootloaderScreen> createState() => _BootloaderScreenState();
}

class _BootloaderScreenState extends State<BootloaderScreen> {
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     Future.delayed(const Duration(seconds: 3), () {
  //       GoRouter.of(context).goNamed("landing");
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          authenticated: (_) {
            Future.delayed(Durations.fast, () {
              context.goNamed("home");
            });
          },
          unAuthenticated: () {
            Future.delayed(Durations.fast, () {
              context.goNamed("landing");
            });
          },
        );
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(
            Assets.logoPng,
            height: size.width * 0.4,
          ),
        ),
      ),
    );
  }
}
