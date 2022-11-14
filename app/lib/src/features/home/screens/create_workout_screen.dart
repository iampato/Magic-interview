// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:magic/src/core/core.dart';
import 'package:magic/src/utils/horizontal_stepper.dart';

class CreateWorkoutScreen extends StatefulWidget {
  const CreateWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<CreateWorkoutScreen> createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  final PageController _pageController = PageController();
  final _options = ["Excercise", "Sets and Reps", "Weights", "Done"];

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
          // SelectProvider(),
          SelectExcercise(
            pageController: _pageController,
          ),
          SelectSetAndReps(
            pageController: _pageController,
          ),
          SelectWeights(
            pageController: _pageController,
          ),
          CreateWorkoutStatus(
            pageController: _pageController,
          ),
        ],
      ),
    );
  }
}

class SelectExcercise extends StatefulWidget {
  final PageController pageController;
  const SelectExcercise({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  State<SelectExcercise> createState() => _SelectExcerciseState();
}

class _SelectExcerciseState extends State<SelectExcercise> {
  final List<String> _excercises = [
    "barbell-row",
    "bench-press",
    "deadlift",
    "shoulder-press",
    "squat",
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: Adapt.setWidth(20),
            right: Adapt.setWidth(20),
            top: Adapt.setHeight(20),
          ),
          child: Text(
            "Select Excercise",
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Adapt.setWidth(20),
          ),
          child: Text(
            "Please tap on the excercise you want to do today",
            style: TextStyles.body3.copyWith(
              color: AppTheme.of(context).grey,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        SizedBox(
          height: Adapt.setHeight(25),
        ),
        Flexible(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: _excercises.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Adapt.setWidth(15),
                  vertical: Adapt.setHeight(1),
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: Corners.s10Border,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Adapt.setHeight(7),
                      horizontal: Adapt.setWidth(15),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/workouts/${_excercises[index]}.gif",
                          height: Adapt.setHeight(110),
                        ),
                        SizedBox(width: Adapt.setWidth(10)),
                        Text(
                          _excercises[index].replaceAll(RegExp(r'-'), ' '),
                          style: TextStyles.body2.semiBold,
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.check_box_outline_blank,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SelectSetAndReps extends StatelessWidget {
  final PageController pageController;
  const SelectSetAndReps({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: Adapt.setWidth(20),
            right: Adapt.setWidth(20),
            top: Adapt.setHeight(20),
          ),
          child: Text(
            "Select sets and reps",
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Adapt.setWidth(20),
          ),
          child: Text(
            "Please enter the number of sets and reps you want to for this workout",
            style: TextStyles.body3.copyWith(
              color: AppTheme.of(context).grey,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        SizedBox(
          height: Adapt.setHeight(30),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Adapt.setWidth(20),
          ),
          child: TextFormField(
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Number of sets e.g 3',
              filled: true,
              fillColor: AppTheme.of(context).surface,
              contentPadding: EdgeInsets.symmetric(
                horizontal: Adapt.setWidth(15),
                vertical: Adapt.setHeight(18),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.of(context).surface!,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.of(context).surface!,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: Adapt.setHeight(10)),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Adapt.setWidth(20),
          ),
          child: TextFormField(
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Number of reps e.g 8',
              filled: true,
              fillColor: AppTheme.of(context).surface,
              contentPadding: EdgeInsets.symmetric(
                horizontal: Adapt.setWidth(15),
                vertical: Adapt.setHeight(18),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.of(context).surface!,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.of(context).surface!,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Adapt.setWidth(20),
            vertical: Adapt.setHeight(12),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(
                double.infinity,
                45,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: Corners.s20Border,
              ),
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () async {
              // go to the next page
              pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: const Text("PROCEED"),
          ),
        ),
      ],
    );
  }
}

class SelectWeights extends StatelessWidget {
  final PageController pageController;
  const SelectWeights({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: Adapt.setWidth(20),
            right: Adapt.setWidth(20),
            top: Adapt.setHeight(20),
          ),
          child: Text(
            "Select weights",
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Adapt.setWidth(20),
          ),
          child: Text(
            "Please enter the weights you want to use for each excercise",
            style: TextStyles.body3.copyWith(
              color: AppTheme.of(context).grey,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        SizedBox(
          height: Adapt.setHeight(30),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Adapt.setWidth(20),
          ),
          child: TextFormField(
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Weight in lbs',
              filled: true,
              fillColor: AppTheme.of(context).surface,
              contentPadding: EdgeInsets.symmetric(
                horizontal: Adapt.setWidth(15),
                vertical: Adapt.setHeight(18),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.of(context).surface!,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.of(context).surface!,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Adapt.setWidth(20),
            vertical: Adapt.setHeight(12),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(
                double.infinity,
                45,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: Corners.s20Border,
              ),
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () async {
              // close the keyboard
              FocusScope.of(context).unfocus();
              // go to the next page
              pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: const Text("PROCEED"),
          ),
        ),
      ],
    );
  }
}

class CreateWorkoutStatus extends StatelessWidget {
  final PageController pageController;
  const CreateWorkoutStatus({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Lottie.asset(
            Assets.success,
            repeat: false,
            height: Adapt.setHeight(160),
          ),
        ),
        SizedBox(height: Adapt.setHeight(30)),
        Text(
          "Success",
          style: TextStyles.h6,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Adapt.setWidth(15),
            vertical: Adapt.setHeight(10),
          ),
          child: AnimatedOpacity(
            opacity: 0.65,
            duration: Durations.fastest,
            child: Text(
              "You have successfully created a workout, please check your workout page to see your new workout",
              textAlign: TextAlign.center,
              style: TextStyles.body3,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Adapt.setWidth(20),
            vertical: Adapt.setHeight(12),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(
                Adapt.screenW() * 0.8,
                45,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: Corners.s20Border,
              ),
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () async {
              // close the keyboard
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            },
            child: const Text("PROCEED"),
          ),
        ),
      ],
    );
  }
}
