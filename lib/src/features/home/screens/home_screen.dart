import 'package:flutter/material.dart';
import 'package:magic/src/core/core.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              iconTheme: IconThemeData(
                color: AppTheme.of(context).primary,
              ),
              elevation: 1,
              backgroundColor: AppTheme.of(context).bg1,
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
                            style: TextStyles.body1.bold.copyWith(
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
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1.5,
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
                        style: TextStyles.h6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: Adapt.setWidth(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Center(
              //   child: Text(
              //     "Patrick Waweru",
              //     style: TextStyles.h7,
              //   ),
              // ),
              // SizedBox(height: Adapt.setHeight(5)),
              // Center(
              //   child: Text(
              //     "858wpwaweru@gmail.com",
              //     style: TextStyles.body3,
              //   ),
              // ),
              // SizedBox(height: Adapt.setHeight(2)),
              // Center(
              //   child: Text(
              //     "+254 700 000 000",
              //     style: TextStyles.body3,
              //   ),
              // ),
              // SizedBox(height: Adapt.setHeight(25)),
              // Text(
              //   "Actions",
              //   style: TextStyles.t1,
              // ),
              // const Divider(),
              // ListTile(
              //   contentPadding: EdgeInsets.zero,
              //   leading: CircleAvatar(
              //     backgroundColor:
              //         AppTheme.of(context).primary?.withOpacity(0.2),
              //     child: Icon(
              //       Icons.edit,
              //       color: AppTheme.of(context).primary,
              //     ),
              //   ),
              //   title: const Text("Edit profile"),
              //   subtitle: Text(
              //     "Update your profile",
              //     style: TextStyles.body4,
              //   ),
              //   trailing: const Icon(Icons.chevron_right),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
