import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:magic/src/features/home/cubit/list%20workout/list_workout_cubit.dart';
import 'package:magic/src/features/landing/cubit/authentication/authentication_cubit.dart';
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
    final user = context.watch<AuthenticationCubit>().user;

    return BlocProvider(
      create: (context) => context.read<ListWorkoutCubit>()..getMyWorkouts(),
      child: Scaffold(
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
                              "Hi, ${user?.name}",
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
                            ),
                          ),
                          margin: EdgeInsets.only(
                            bottom: Adapt.setHeight(4),
                          ),
                          height: Adapt.setHeight(39),
                          width: Adapt.setHeight(39),
                          alignment: Alignment.center,
                          child: Text(
                            "${user?.name[0]}",
                            style: TextStyles.h6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: BlocConsumer<ListWorkoutCubit, ListWorkoutState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                success: (_, __, message) {
                  if (message != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                      ),
                    );
                  }
                },
              );
            },
            builder: (context, state) {
              return state.when(
                initial: () {
                  return Center(
                    child: Lottie.asset(
                      Assets.loading,
                      height: Adapt.setHeight(260),
                      fit: BoxFit.fitHeight,
                    ),
                  );
                },
                success: (_, workoutResponse, __) {
                  if (workoutResponse.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Lottie.asset(
                            Assets.error,
                            height: Adapt.setHeight(250),
                          ),
                        ),
                        SizedBox(height: Adapt.setHeight(30)),
                        Text(
                          "You have no workouts",
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
                              "Please tap the button below to create a workout",
                              textAlign: TextAlign.center,
                              style: TextStyles.body3,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return ListView.builder(
                    controller: controller,
                    padding: EdgeInsets.only(
                      top: Adapt.setHeight(20),
                      bottom: Adapt.setHeight(50),
                      left: Adapt.setWidth(15),
                      right: Adapt.setWidth(15),
                    ),
                    itemCount: workoutResponse.length,
                    itemBuilder: (context, index) {
                      final item = workoutResponse[index];
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
                              item?.month ?? "",
                              style: TextStyles.body1.semiBold,
                            ),
                          ),
                          content: Padding(
                            padding: EdgeInsets.only(
                              bottom: Adapt.setHeight(10),
                            ),
                            child: Column(
                              children: item!.workouts.map((e) {
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                // 13th nov 13:00
                                                DateFormat("d MMM, HH:mm")
                                                    .format(e.dateCreatedAt),
                                                style:
                                                    TextStyles.body2.copyWith(
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
                                                      height:
                                                          Adapt.setHeight(7),
                                                      width: Adapt.setHeight(7),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            AppTheme.of(context)
                                                                .grey,
                                                      ),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            Adapt.setWidth(7),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${e.noOfReps} reps",
                                                      style: TextStyles.body3,
                                                    ),
                                                    Container(
                                                      height:
                                                          Adapt.setHeight(7),
                                                      width: Adapt.setHeight(7),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            AppTheme.of(context)
                                                                .grey,
                                                      ),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            Adapt.setWidth(7),
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
                  );
                },
                error: (error) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Lottie.asset(
                          Assets.error,
                          height: Adapt.setHeight(160),
                        ),
                      ),
                      SizedBox(height: Adapt.setHeight(30)),
                      Text(
                        "Error",
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
                            error,
                            textAlign: TextAlign.center,
                            style: TextStyles.body3,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
