import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magic/src/features/home/screens/create_workout_screen.dart';
import 'package:magic/src/features/home/screens/home_screen.dart';
import 'package:magic/src/features/home/screens/profile_screen.dart';
import 'package:magic/src/features/home/screens/workout_detail_screen.dart';

final homeNavigation = <GoRoute>[
  GoRoute(
    name: 'home',
    path: '/home',
    pageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: const HomeScreen(),
    ),
    routes: [
      // create workout
      GoRoute(
        name: 'create-workout',
        path: 'create',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const CreateWorkoutScreen(),
        ),
      ),
      GoRoute(
        name: 'workout_detail',
        path: 'workout/:id',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const WorkoutDetailScreen(),
        ),
      ),
    ],
  ),
  GoRoute(
    name: 'profile',
    path: '/profile',
    pageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: const ProfileScreen(),
    ),
  ),
];
