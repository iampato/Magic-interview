import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:magic/src/core/core.dart';
import 'package:magic/src/features/home/cubit/list%20workout/list_workout_cubit.dart';
import 'package:magic/src/features/home/model/workout_response.dart';
import 'package:magic/src/widgets/button_loading.dart';
import 'package:sticky_headers/sticky_headers.dart';

class WorkoutItem extends StatefulWidget {
  const WorkoutItem({
    Key? key,
    required this.controller,
    required this.item,
  }) : super(key: key);

  final ScrollController controller;
  final WorkoutResponse? item;

  @override
  State<WorkoutItem> createState() => _WorkoutItemState();
}

class _WorkoutItemState extends State<WorkoutItem> {
  String? _id;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Adapt.setHeight(5),
      ),
      child: StickyHeader(
        controller: widget.controller, // Optional
        header: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppTheme.of(context).surface,
          ),
          padding: EdgeInsets.symmetric(
            vertical: Adapt.setHeight(10),
          ),
          child: Text(
            widget.item?.month ?? "",
            style: TextStyles.body1.semiBold,
          ),
        ),
        content: Padding(
          padding: EdgeInsets.only(
            bottom: Adapt.setHeight(10),
          ),
          child: Column(
            children: widget.item!.workouts.map((e) {
              return InkWell(
                borderRadius: Corners.s10Border,
                onTap: () {
                  context.pushNamed(
                    'workout_detail',
                    params: {'id': e.id},
                    extra: e,
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
                              // 13th nov 13:00
                              DateFormat("d MMM, HH:mm")
                                  .format(e.dateCreatedAt),
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
                                e.type,
                                style: TextStyles.body2,
                              ),
                            ),
                            AnimatedOpacity(
                              opacity: 0.7,
                              duration: Durations.fastest,
                              child: Row(
                                children: [
                                  Text(
                                    "${e.noOfSets} sets",
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
                                    "${e.noOfReps} reps",
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
                        onPressed: () {
                          setState(() {
                            _id = e.id;
                          });
                          // delete workout
                          context
                              .read<ListWorkoutCubit>()
                              .deleteWorkout(workoutId: e.id);
                        },
                        icon: _id == e.id
                            ? const ButtonLoading()
                            : Icon(
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
  }
}
