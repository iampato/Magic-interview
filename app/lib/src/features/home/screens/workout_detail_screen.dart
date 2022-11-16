// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:magic/src/core/core.dart';
import 'package:magic/src/features/home/cubit/list%20workout/list_workout_cubit.dart';
import 'package:magic/src/features/home/model/create_workout_request.dart';
import 'package:magic/src/features/home/model/workout_model.dart';
import 'package:magic/src/widgets/button_loading.dart';

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
  late CreateWorkoutRequest _createWorkoutRequest;
  String? _id;
  final mapEditState = {
    "excercise": false,
    "sets": false,
    "reps": false,
    "weight": false,
  };

  @override
  void initState() {
    _createWorkoutRequest = CreateWorkoutRequest(
      type: workoutModel.type,
      noOfSets: workoutModel.noOfSets,
      noOfReps: workoutModel.noOfReps,
      weight: workoutModel.weight,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).surface,
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {},
      //   label: const Text('Save changes'),
      // ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _id = workoutModel.id;
                    });
                    // delete workout
                    context
                        .read<ListWorkoutCubit>()
                        .deleteWorkout(workoutId: workoutModel.id);
                    Future.delayed(Durations.medium, () {
                      Navigator.pop(context);
                    });
                  },
                  icon: _id == workoutModel.id
                      ? const ButtonLoading()
                      : const Icon(Icons.delete_outline),
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
              _buildType(context),
              _buildSets(context),
              _buildWeight(context),
              _buildReps(context),
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

  Widget _buildType(BuildContext context) {
    final globalFormKey = GlobalKey<FormState>();
    final excercises = [
      "barbell-row",
      "bench-press",
      "deadlift",
      "shoulder-press",
      "squat"
    ];
    String type = workoutModel.type;
    if (mapEditState["excercise"]!) {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: Adapt.setHeight(10),
        ),
        child: Form(
          key: globalFormKey,
          child: DropdownButtonFormField<String>(
            items: [
              for (final option in excercises)
                DropdownMenuItem(
                  value: option,
                  child: Text(option),
                ),
            ],
            value: type,
            autofocus: true,
            onChanged: (value) {},
            decoration: InputDecoration(
              labelText: 'Weight in lbs',
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
              suffixIcon: IconButton(
                onPressed: () {
                  if (globalFormKey.currentState!.validate()) {
                    globalFormKey.currentState!.save();
                    if (workoutModel.type != type) {
                      final editWorkOut = _createWorkoutRequest.copyWith(
                        type: type,
                      );
                      context.read<ListWorkoutCubit>().editWorkout(
                            workoutId: workoutModel.id,
                            request: editWorkOut,
                          );
                      setState(() {
                        workoutModel.type = type;
                      });
                    }
                    setState(() {
                      mapEditState["excercise"] = false;
                    });
                  }
                },
                icon: const Icon(Icons.done),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.of(context).surface!,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a weight';
              }
              return null;
            },
            onSaved: (newValue) {
              if (newValue != null) {
                type = newValue;
              }
            },
          ),
        ),
      );
    } else {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(workoutModel.type),
        subtitle: Text(
          "Type of exercise",
          style: TextStyles.body3,
        ),
        trailing: const Icon(Icons.edit),
        onTap: () {
          setState(() {
            mapEditState["excercise"] = true;
          });
        },
      );
    }
  }

  Widget _buildSets(BuildContext context) {
    final globalFormKey = GlobalKey<FormState>();
    int sets = workoutModel.noOfSets;
    if (mapEditState["sets"]!) {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: Adapt.setHeight(10),
        ),
        child: Form(
          key: globalFormKey,
          child: TextFormField(
            initialValue: sets.toString(),
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Number of sets e.g 3',
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
              suffixIcon: IconButton(
                onPressed: () {
                  if (globalFormKey.currentState!.validate()) {
                    globalFormKey.currentState!.save();
                    if (workoutModel.noOfSets != sets) {
                      final editWorkOut = _createWorkoutRequest.copyWith(
                        noOfSets: int.tryParse(sets.toString()) ?? 0,
                      );
                      context.read<ListWorkoutCubit>().editWorkout(
                            workoutId: workoutModel.id,
                            request: editWorkOut,
                          );
                      setState(() {
                        workoutModel.noOfSets = sets;
                      });
                    }
                    setState(() {
                      mapEditState["sets"] = false;
                    });
                  }
                },
                icon: const Icon(Icons.done),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.of(context).surface!,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the number of sets';
              }
              return null;
            },
            onSaved: (newValue) {
              if (newValue != null) {
                sets = int.tryParse(newValue) ?? 0;
              }
            },
          ),
        ),
      );
    } else {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(workoutModel.noOfSets.toString()),
        subtitle: Text(
          "No. of sets",
          style: TextStyles.body3,
        ),
        trailing: const Icon(Icons.edit),
        onTap: () {
          setState(() {
            mapEditState["sets"] = true;
          });
        },
      );
    }
  }

  Widget _buildWeight(BuildContext context) {
    final globalFormKey = GlobalKey<FormState>();
    double weight = workoutModel.weight;
    if (mapEditState["weight"]!) {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: Adapt.setHeight(10),
        ),
        child: Form(
          key: globalFormKey,
          child: TextFormField(
            initialValue: weight.toString(),
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Weight in lbs',
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
              suffixIcon: IconButton(
                onPressed: () {
                  if (globalFormKey.currentState!.validate()) {
                    globalFormKey.currentState!.save();
                    if (workoutModel.weight != weight) {
                      final editWorkOut = _createWorkoutRequest.copyWith(
                        weight: double.tryParse(weight.toString()) ?? 0,
                      );
                      context.read<ListWorkoutCubit>().editWorkout(
                            workoutId: workoutModel.id,
                            request: editWorkOut,
                          );
                      setState(() {
                        workoutModel.weight = weight;
                      });
                    }
                    setState(() {
                      mapEditState["weight"] = false;
                    });
                  }
                },
                icon: const Icon(Icons.done),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.of(context).surface!,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a weight';
              }
              return null;
            },
            onSaved: (newValue) {
              if (newValue != null) {
                weight = double.tryParse(newValue) ?? 0;
              }
            },
          ),
        ),
      );
    } else {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text("${workoutModel.weight} lbs"),
        subtitle: Text(
          "Weight used",
          style: TextStyles.body3,
        ),
        trailing: const Icon(Icons.edit),
        onTap: () {
          setState(() {
            mapEditState["weight"] = true;
          });
        },
      );
    }
  }

  Widget _buildReps(BuildContext context) {
    final globalFormKey = GlobalKey<FormState>();
    int reps = workoutModel.noOfReps;
    if (mapEditState["reps"]!) {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: Adapt.setHeight(10),
        ),
        child: Form(
          key: globalFormKey,
          child: TextFormField(
            initialValue: reps.toString(),
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Number of reps e.g 3',
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
              suffixIcon: IconButton(
                onPressed: () {
                  if (globalFormKey.currentState!.validate()) {
                    globalFormKey.currentState!.save();
                    if (workoutModel.noOfReps != reps) {
                      final editWorkOut = _createWorkoutRequest.copyWith(
                        noOfReps: int.tryParse(reps.toString()) ?? 0,
                      );
                      context.read<ListWorkoutCubit>().editWorkout(
                            workoutId: workoutModel.id,
                            request: editWorkOut,
                          );
                      setState(() {
                        workoutModel.noOfReps = reps;
                      });
                    }
                    setState(() {
                      mapEditState["reps"] = false;
                    });
                  }
                },
                icon: const Icon(Icons.done),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.of(context).surface!,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the number of reps';
              }
              return null;
            },
            onSaved: (newValue) {
              if (newValue != null) {
                reps = int.tryParse(newValue) ?? 0;
              }
            },
          ),
        ),
      );
    } else {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(workoutModel.noOfReps.toString()),
        subtitle: Text(
          "No. of reps performed per set",
          style: TextStyles.body3,
        ),
        trailing: const Icon(Icons.edit),
        onTap: () {
          setState(() {
            mapEditState["reps"] = true;
          });
        },
      );
    }
  }
}
