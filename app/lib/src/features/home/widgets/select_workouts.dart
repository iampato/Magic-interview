

import 'package:flutter/material.dart';
import 'package:magic/src/core/core.dart';

class SelectExcercise extends StatefulWidget {
  final Function(String type) onSelected;
  final PageController pageController;
  const SelectExcercise({
    Key? key,
    required this.onSelected,
    required this.pageController,
  }) : super(key: key);

  @override
  State<SelectExcercise> createState() => _SelectExcerciseState();
}

class _SelectExcerciseState extends State<SelectExcercise> {
  final List<String> _excercises = [
    "barbell-row",
    "bench-press",
    "deadlift",
    "shoulder-press",
    "squat",
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: Adapt.setWidth(20),
            right: Adapt.setWidth(20),
            top: Adapt.setHeight(20),
          ),
          child: Text(
            "Select Excercise",
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Adapt.setWidth(20),
          ),
          child: Text(
            "Please tap on the excercise you want to do today",
            style: TextStyles.body3.copyWith(
              color: AppTheme.of(context).grey,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        SizedBox(
          height: Adapt.setHeight(25),
        ),
        Flexible(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: _excercises.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Adapt.setWidth(15),
                  vertical: Adapt.setHeight(1),
                ),
                child: GestureDetector(
                  onTap: () {
                    widget.onSelected(_excercises[index]);
                    widget.pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: Corners.s10Border,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Adapt.setHeight(7),
                        horizontal: Adapt.setWidth(15),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/workouts/${_excercises[index]}.gif",
                            height: Adapt.setHeight(110),
                          ),
                          SizedBox(width: Adapt.setWidth(10)),
                          Text(
                            _excercises[index].replaceAll(RegExp(r'-'), ' '),
                            style: TextStyles.body2.semiBold,
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.check_box_outline_blank,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}