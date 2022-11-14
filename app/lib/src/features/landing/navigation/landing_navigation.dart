import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magic/src/features/landing/screens/bootloader_screen.dart';
import 'package:magic/src/features/landing/screens/landing_screen.dart';

final landingNavigation = <GoRoute>[
  GoRoute(
    name: 'bootloader',
    path: '/',
    pageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: const BootloaderScreen(),
    ),
  ),
  GoRoute(
    name: 'landing',
    path: '/landing',
    pageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: const LandingScreen(),
    ),
  ),
];
