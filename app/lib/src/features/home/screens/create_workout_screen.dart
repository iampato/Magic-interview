// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:magic/src/core/core.dart';
import 'package:magic/src/features/home/model/create_workout_request.dart';
import 'package:magic/src/features/home/widgets/create_workout_status.dart';
import 'package:magic/src/features/home/widgets/select_reps.dart';
import 'package:magic/src/features/home/widgets/select_weight.dart';
import 'package:magic/src/features/home/widgets/select_workouts.dart';
import 'package:magic/src/widgets/horizontal_stepper.dart';

class CreateWorkoutScreen extends StatefulWidget {
  const CreateWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<CreateWorkoutScreen> createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  final PageController _pageController = PageController();
  final _options = ["Excercise", "Sets and Reps", "Weights", "Done"];
  final CreateWorkoutRequest _createWorkoutRequest = CreateWorkoutRequest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HorizontalStepper(
        controller: _pageController,
        options: _options,
        initialPage: 0,
        activeTextColor: AppTheme.of(context).primaryLight,
        inactiveTextColor: AppTheme.of(context).grey,
        activeColor: AppTheme.of(context).primaryLight,
        inactiveColor: AppTheme.of(context).grey,
        physics: const ClampingScrollPhysics(),
        steps: [
          SelectExcercise(
            pageController: _pageController,
            onSelected: (type) {
              _createWorkoutRequest.type = type;
            },
          ),
          SelectSetAndReps(
            pageController: _pageController,
            onSelected: (sets, reps) {
              _createWorkoutRequest.noOfSets = sets;
              _createWorkoutRequest.noOfReps = reps;
            },
          ),
          SelectWeights(
            pageController: _pageController,
            createWorkoutRequest: _createWorkoutRequest,
          ),
          CreateWorkoutStatus(
            pageController: _pageController,
          ),
        ],
      ),
    );
  }
}
