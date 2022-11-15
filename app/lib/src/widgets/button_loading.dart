import 'package:flutter/material.dart';
import 'package:magic/src/core/core.dart';

class ButtonLoading extends StatelessWidget {
  const ButtonLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Adapt.setHeight(20),
      width: Adapt.setHeight(20),
      child: CircularProgressIndicator(
        strokeWidth: 1.5,
        color: AppTheme.of(context).accent1,
        backgroundColor: Colors.white,
      ),
    );
  }
}
