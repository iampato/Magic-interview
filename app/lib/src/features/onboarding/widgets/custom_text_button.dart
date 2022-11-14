import 'package:flutter/cupertino.dart';
import 'package:magic/src/core/core.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const CustomTextButton({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyles.body3.copyWith(
                color: AppTheme.of(context).grey,
              ),
            ),
            SizedBox(width: Adapt.setWidth(5)),
            Icon(
              CupertinoIcons.arrow_right,
              color: AppTheme.of(context).grey,
              size: Adapt.setRadius(20),
            ),
          ],
        ),
      ),
    );
  }
}
