// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:magic/src/core/core.dart';
import 'package:magic/src/features/home/model/workout_model.dart';

class WorkoutDetailScreen extends StatefulWidget {
  final WorkoutModel workoutModel;
  const WorkoutDetailScreen({
    Key? key,
    required this.workoutModel,
  }) : super(key: key);

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  WorkoutModel get workoutModel => widget.workoutModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).surface,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Save changes'),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete_outline),
                )
              ],
              pinned: true,
              iconTheme: IconThemeData(
                color: AppTheme.of(context).primary,
              ),
              backgroundColor: AppTheme.of(context).surface,
              expandedHeight: Adapt.screenH() * 0.3,
              flexibleSpace: FlexibleSpaceBar(
                // expandedTitleScale: 2.2,
                title: Image.asset(
                  "assets/workouts/${workoutModel.type}.gif",
                  height: Adapt.setHeight(90),
                ),
                centerTitle: true,
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          // physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: Adapt.setWidth(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(workoutModel.type),
                subtitle: Text(
                  "Type of exercise",
                  style: TextStyles.body3,
                ),
                trailing: const Icon(Icons.edit),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(workoutModel.noOfSets.toString()),
                subtitle: Text(
                  "No. of sets",
                  style: TextStyles.body3,
                ),
                trailing: const Icon(Icons.edit),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text("${workoutModel.weight} lbs"),
                subtitle: Text(
                  "Weight used",
                  style: TextStyles.body3,
                ),
                trailing: const Icon(Icons.edit),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(workoutModel.noOfReps.toString()),
                subtitle: Text(
                  "No. of reps performed per set",
                  style: TextStyles.body3,
                ),
                trailing: const Icon(Icons.edit),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  DateFormat.yMMMEd().format(workoutModel.dateCreatedAt),
                ),
                subtitle: Text(
                  "Date and time of the workout",
                  style: TextStyles.body3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
