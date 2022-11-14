import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'package:magic/src/core/core.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).surface,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.pushNamed("create-workout");
        },
        label: const Text('Create'),
        icon: const Icon(Icons.add),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              iconTheme: IconThemeData(
                color: AppTheme.of(context).primary,
              ),
              elevation: 1,
              // backgroundColor: AppTheme.of(context).primaryLight!,
              expandedHeight: Adapt.screenH() * 0.15,
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1.2,
                titlePadding: EdgeInsets.only(
                  left: Adapt.setWidth(15),
                  right: Adapt.setWidth(15),
                  bottom: Adapt.setHeight(5),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, Patrick",
                            style: TextStyles.h6.bold.copyWith(
                              height: 0.7,
                            ),
                          ),
                          AnimatedOpacity(
                            opacity: 0.7,
                            duration: Durations.fastest,
                            child: Text(
                              "Let's do something great today",
                              style: TextStyles.body4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed('profile');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1.5,
                            color: AppTheme.of(context).surface!,
                          ),
                        ),
                        margin: EdgeInsets.only(
                          bottom: Adapt.setHeight(4),
                        ),
                        height: Adapt.setHeight(36),
                        width: Adapt.setHeight(36),
                        alignment: Alignment.center,
                        child: Text(
                          "P",
                          style: TextStyles.h6.copyWith(
                            color: AppTheme.of(context).surface!,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: ListView.builder(
          controller: controller,
          padding: EdgeInsets.only(
            top: Adapt.setHeight(20),
            bottom: Adapt.setHeight(50),
            left: Adapt.setWidth(15),
            right: Adapt.setWidth(15),
          ),
          itemCount: _workouts.length,
          itemBuilder: (context, index) {
            final item = _workouts[index];
            // return workout item
            return Padding(
              padding: EdgeInsets.only(
                bottom: Adapt.setHeight(5),
              ),
              child: StickyHeader(
                controller: controller, // Optional
                header: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.of(context).surface,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: Adapt.setHeight(10),
                  ),
                  child: Text(
                    item.dateTime,
                    style: TextStyles.body1.semiBold,
                  ),
                ),
                content: Padding(
                  padding: EdgeInsets.only(
                    bottom: Adapt.setHeight(10),
                  ),
                  child: Column(
                    children: item.items.map((e) {
                      return InkWell(
                        borderRadius: Corners.s10Border,
                        onTap: () {
                          context.pushNamed(
                            'workout_detail',
                            params: {'id': "123"},
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: Adapt.setHeight(10),
                            horizontal: Adapt.setWidth(15),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/workouts/${e.type}.gif",
                                height: Adapt.setHeight(75),
                              ),
                              SizedBox(
                                width: Adapt.setWidth(10),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.date,
                                      style: TextStyles.body2.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Adapt.setHeight(3),
                                    ),
                                    AnimatedOpacity(
                                      opacity: 0.7,
                                      duration: Durations.fastest,
                                      child: Text(
                                        e.title,
                                        style: TextStyles.body2,
                                      ),
                                    ),
                                    AnimatedOpacity(
                                      opacity: 0.7,
                                      duration: Durations.fastest,
                                      child: Row(
                                        children: [
                                          Text(
                                            "${e.numberOfSets} sets",
                                            style: TextStyles.body3,
                                          ),
                                          Container(
                                            height: Adapt.setHeight(7),
                                            width: Adapt.setHeight(7),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppTheme.of(context).grey,
                                            ),
                                            margin: EdgeInsets.symmetric(
                                              horizontal: Adapt.setWidth(7),
                                            ),
                                          ),
                                          Text(
                                            "${e.reps} reps",
                                            style: TextStyles.body3,
                                          ),
                                          Container(
                                            height: Adapt.setHeight(7),
                                            width: Adapt.setHeight(7),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppTheme.of(context).grey,
                                            ),
                                            margin: EdgeInsets.symmetric(
                                              horizontal: Adapt.setWidth(7),
                                            ),
                                          ),
                                          Text(
                                            "${e.weight} lbs",
                                            style: TextStyles.body3,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: Adapt.setWidth(10),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: AppTheme.of(context).grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class WorkoutItem {
  final String title;
  final String date;
  final int numberOfSets;
  final String type;
  final double weight;
  final int reps;

  WorkoutItem({
    required this.title,
    required this.date,
    required this.numberOfSets,
    required this.type,
    required this.weight,
    required this.reps,
  });
}

class WorkOut {
  final String dateTime;
  final List<WorkoutItem> items;
  WorkOut({
    required this.dateTime,
    required this.items,
  });
}

// dummy list of workouts
final _workouts = [
  WorkOut(
    dateTime: "November 2022",
    items: [
      WorkoutItem(
        title: "Bench Press",
        date: "14th Nov 12:00",
        numberOfSets: 3,
        type: "bench-press",
        weight: 100,
        reps: 10,
      ),
      WorkoutItem(
        title: "Squats",
        date: "13th Nov 18:03",
        numberOfSets: 3,
        type: "squat",
        weight: 100,
        reps: 10,
      ),
      WorkoutItem(
        title: "Deadlifts",
        date: "10th Nov 12:00",
        numberOfSets: 3,
        type: "deadlift",
        weight: 100,
        reps: 10,
      ),
      WorkoutItem(
        title: "Barbell row",
        date: "2nd Nov 08:00",
        numberOfSets: 3,
        type: "barbell-row",
        weight: 100,
        reps: 10,
      ),
      WorkoutItem(
        title: "Shoulder Press",
        date: "1st Nov 22:00",
        numberOfSets: 3,
        type: "shoulder-press",
        weight: 100,
        reps: 10,
      ),
    ],
  ),
  WorkOut(
    dateTime: "October 2022",
    items: [
      WorkoutItem(
        title: "Bench Press",
        date: "30th Oct 18:03",
        numberOfSets: 3,
        type: "bench-press",
        weight: 100,
        reps: 10,
      ),
      WorkoutItem(
        title: "Squats",
        date: "29th Oct 12:00",
        numberOfSets: 3,
        type: "squat",
        weight: 100,
        reps: 10,
      ),
      WorkoutItem(
        title: "Shoulder Press",
        date: "28th Oct 08:00",
        numberOfSets: 3,
        type: "shoulder-press",
        weight: 100,
        reps: 10,
      ),
    ],
  ),
  WorkOut(
    dateTime: "September 2022",
    items: [
      WorkoutItem(
        title: "Squats",
        date: "30th Sep 18:03",
        numberOfSets: 3,
        type: "squat",
        weight: 100,
        reps: 10,
      ),
      WorkoutItem(
        title: "Deadlifts",
        date: "27th Sep 12:00",
        numberOfSets: 3,
        type: "deadlift",
        weight: 100,
        reps: 10,
      ),
      WorkoutItem(
        title: "Barbell row",
        date: "25th Sep 08:00",
        numberOfSets: 3,
        type: "barbell-row",
        weight: 100,
        reps: 10,
      ),
      WorkoutItem(
        title: "Shoulder Press",
        date: "24th Sep 22:00",
        numberOfSets: 3,
        type: "shoulder-press",
        weight: 100,
        reps: 10,
      ),
    ],
  ),
  WorkOut(
    dateTime: "August 2022",
    items: [
      WorkoutItem(
        title: "Bench Press",
        date: "30th Aug 18:03",
        numberOfSets: 3,
        type: "bench-press",
        weight: 100,
        reps: 10,
      ),
    ],
  ),
  WorkOut(
    dateTime: "July 2022",
    items: [
      WorkoutItem(
        title: "Barbell row",
        date: "30th Jul 18:03",
        numberOfSets: 3,
        type: "barbell-row",
        weight: 100,
        reps: 10,
      ),
      WorkoutItem(
        title: "Shoulder Press",
        date: "29th Jul 12:00",
        numberOfSets: 3,
        type: "shoulder-press",
        weight: 100,
        reps: 10,
      ),
    ],
  ),
];
