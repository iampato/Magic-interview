import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:magic/src/core/core.dart';
import 'package:magic/src/features/home/cubit/list%20workout/list_workout_cubit.dart';
import 'package:magic/src/features/landing/cubit/authentication/authentication_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthenticationCubit>().user;
    return Scaffold(
      backgroundColor: AppTheme.of(context).surface,
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
              expandedHeight: Adapt.screenH() * 0.15,
              flexibleSpace: FlexibleSpaceBar(
                // expandedTitleScale: 2.2,
                title: CircleAvatar(
                  backgroundColor: AppTheme.of(context).primary!,
                  child: Text(
                    "P",
                    style: TextStyles.h6.copyWith(
                      color: AppTheme.of(context).surface!,
                    ),
                  ),
                ),
                centerTitle: true,
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          // physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: Adapt.setWidth(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  user?.name ?? "No Name",
                  style: TextStyles.h7,
                ),
              ),
              SizedBox(height: Adapt.setHeight(5)),
              Center(
                child: Text(
                  user?.email ?? "No email",
                  style: TextStyles.body3,
                ),
              ),
              SizedBox(height: Adapt.setHeight(2)),
              SizedBox(height: Adapt.setHeight(25)),
              Text(
                "Actions",
                style: TextStyles.t1,
              ),
              const Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor:
                      AppTheme.of(context).primary?.withOpacity(0.2),
                  child: Icon(
                    Icons.edit,
                    color: AppTheme.of(context).primary,
                  ),
                ),
                title: const Text("Edit profile"),
                subtitle: Text(
                  "Update your profile",
                  style: TextStyles.body4,
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor:
                      AppTheme.of(context).primary?.withOpacity(0.2),
                  child: Icon(
                    Icons.info_outline,
                    color: AppTheme.of(context).primary,
                  ),
                ),
                title: const Text("Our agreement"),
                subtitle: Text(
                  "Read our agreement",
                  style: TextStyles.body4,
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor:
                      AppTheme.of(context).primary?.withOpacity(0.2),
                  child: Icon(
                    Icons.share,
                    color: AppTheme.of(context).primary,
                  ),
                ),
                title: const Text("Share app"),
                subtitle: Text(
                  "Share app with friends",
                  style: TextStyles.body4,
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor:
                      AppTheme.of(context).primary?.withOpacity(0.2),
                  child: Icon(
                    Icons.mail_outline,
                    color: AppTheme.of(context).primary,
                  ),
                ),
                title: const Text("Contacts us"),
                subtitle: Text(
                  "Send us a message",
                  style: TextStyles.body4,
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                onTap: () {
                  context.read<ListWorkoutCubit>().clearState();
                  context.read<AuthenticationCubit>().logOut();
                  context.goNamed("bootloader");
                },
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor:
                      AppTheme.of(context).primary?.withOpacity(0.2),
                  child: Icon(
                    Icons.exit_to_app,
                    color: AppTheme.of(context).primary,
                  ),
                ),
                title: const Text("Logout"),
                subtitle: Text(
                  "Sad to see you go",
                  style: TextStyles.body4,
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
              SizedBox(height: Adapt.setHeight(20)),
              Center(
                  child: Text(
                "MAGIC",
                style: TextStyles.btn,
              )),
              const AnimatedOpacity(
                opacity: 0.6,
                duration: Durations.fast,
                child: Center(child: Text("v 1.0.0")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
