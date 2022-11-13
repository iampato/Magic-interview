import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magic/src/features/onboarding/screens/account_screen.dart';
import 'package:magic/src/features/onboarding/screens/add_user_screen.dart';
import 'package:magic/src/features/onboarding/screens/forgot_screen.dart';
import 'package:magic/src/features/onboarding/screens/login_screen.dart';
import 'package:magic/src/features/onboarding/screens/register_screen.dart';

final onboardingNavigation = <GoRoute>[
  GoRoute(
    name: 'login',
    path: '/login',
    pageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: const LoginScreen(),
    ),
  ),
  GoRoute(
    name: 'register',
    path: '/register',
    pageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: const RegisterScreen(),
    ),
  ),
  GoRoute(
    name: 'forgot',
    path: '/forgot',
    pageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: const ForgotScreen(),
    ),
  ),
  GoRoute(
    name: 'account',
    path: '/account',
    pageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: const AccountScreen(),
    ),
    routes: [
      GoRoute(
        name: 'account-add',
        path: 'add',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const AddUserScreen(),
        ),
      ),
    ],
  ),
];
