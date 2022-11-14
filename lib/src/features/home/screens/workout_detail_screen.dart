import 'package:flutter/material.dart';
import 'package:magic/src/core/core.dart';

class WorkoutDetailScreen extends StatefulWidget {
  const WorkoutDetailScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
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
                  "assets/workouts/bench-press.gif",
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
                title: const Text("Bench press"),
                subtitle: Text(
                  "Type of exercise",
                  style: TextStyles.body3,
                ),
                trailing: const Icon(Icons.edit),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("12"),
                subtitle: Text(
                  "No. of sets",
                  style: TextStyles.body3,
                ),
                trailing: const Icon(Icons.edit),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("100 lbs"),
                subtitle: Text(
                  "Weight used",
                  style: TextStyles.body3,
                ),
                trailing: const Icon(Icons.edit),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("3"),
                subtitle: Text(
                  "No. of reps performed per set",
                  style: TextStyles.body3,
                ),
                trailing: const Icon(Icons.edit),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("12/11/2022 12:00 PM"),
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
