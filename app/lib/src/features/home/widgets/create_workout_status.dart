// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:magic/src/core/core.dart';

class CreateWorkoutStatus extends StatelessWidget {
  final PageController pageController;
  
  const CreateWorkoutStatus({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Lottie.asset(
            Assets.success,
            repeat: false,
            height: Adapt.setHeight(160),
          ),
        ),
        SizedBox(height: Adapt.setHeight(30)),
        Text(
          "Success",
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
              "You have successfully created a workout, please check your workout page to see your new workout",
              textAlign: TextAlign.center,
              style: TextStyles.body3,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Adapt.setWidth(20),
            vertical: Adapt.setHeight(12),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(
                Adapt.screenW() * 0.8,
                45,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: Corners.s20Border,
              ),
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () async {
              // close the keyboard
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            },
            child: const Text("PROCEED"),
          ),
        ),
      ],
    );
  }
}
