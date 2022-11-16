import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:magic/src/features/home/cubit/list%20workout/list_workout_cubit.dart';
import 'package:magic/src/features/home/widgets/workout_item.dart';
import 'package:magic/src/features/landing/cubit/authentication/authentication_cubit.dart';

import 'package:magic/src/core/core.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  Future<void> _pullRefresh() async {
    await context.read<ListWorkoutCubit>().getMyWorkouts();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ListWorkoutCubit>().getMyWorkouts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthenticationCubit>().user;
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
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: NestedScrollView(
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
                      return WorkoutItem(
                        controller: controller,
                        item: item,
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
