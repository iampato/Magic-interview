import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magic/src/features/home/navigation/home_navigation.dart';
import 'package:magic/src/features/landing/navigation/landing_navigation.dart';
import 'package:magic/src/features/onboarding/navigation/onboarding_navigation.dart';

GoRouter router = GoRouter(
  routes: [
    ...landingNavigation,
    ...onboardingNavigation,
    ...homeNavigation,
  ],
  initialLocation: "/",
  errorBuilder: (error, stackTrace) => Scaffold(
    body: Center(
      child: Text(
        '$error',
        textAlign: TextAlign.center,
      ),
    ),
  ),
);
