import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:magic/src/core/core.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              Assets.loginWorkout,
              height: Adapt.screenH() * 0.35,
            ),
          ),
          SizedBox(height: Adapt.setHeight(10)),
          Text('MAGIC', style: TextStyles.h5),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Adapt.setWidth(20),
            ),
            child: AnimatedOpacity(
              opacity: 0.7,
              duration: Durations.fast,
              child: Text(
                'The beautifully designed home fitness system that gives you hyper-personalised training on-demand',
                textAlign: TextAlign.center,
                style: TextStyles.body2,
              ),
            ),
          ),
          SizedBox(height: Adapt.setHeight(55)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Adapt.setWidth(25),
            ),
            child: ElevatedButton(
              onPressed: () {
                context.pushNamed("login");
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                  double.infinity,
                  Adapt.setHeight(55),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: Corners.s10Border,
                ),
              ),
              child: Text(
                "Login".toUpperCase(),
                style: TextStyles.body1,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Adapt.setWidth(25),
              vertical: Adapt.setHeight(15),
            ),
            child: OutlinedButton(
              onPressed: () {
                context.pushNamed("register");
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  width: 3,
                  color: AppTheme.of(context).primary!,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: Corners.s10Border,
                ),
                minimumSize: Size(
                  double.infinity,
                  Adapt.setHeight(55),
                ),
              ),
              child: Text(
                "Signup".toUpperCase(),
                style: TextStyles.body1.copyWith(
                  color: AppTheme.of(context).primaryLight,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
