import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magic/src/features/home/screens/home_screen.dart';

final homeNavigation = <GoRoute>[
  GoRoute(
    name: 'home',
    path: '/home',
    pageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: const HomeScreen(),
    ),
  ),
];
