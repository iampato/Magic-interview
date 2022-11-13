import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import 'package:magic/src/core/core.dart';
import 'package:magic/src/core/styles.dart';
import 'package:magic/src/features/onboarding/widgets/custom_text_button.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Adapt.setWidth(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Adapt.screenH() * 0.05),
            Padding(
              padding: EdgeInsets.only(left: Adapt.setWidth(2)),
              child: Text(
                "Who is using?".toUpperCase(),
                style: TextStyles.h5.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: Adapt.setWidth(2)),
              child: AnimatedOpacity(
                opacity: 0.5,
                duration: Durations.fast,
                child: Text(
                  "Who is exercise today? you can add more people now or later",
                  style: TextStyles.body2,
                ),
              ),
            ),
            SizedBox(height: Adapt.setHeight(35)),
            GridView(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: Adapt.setWidth(5),
                mainAxisSpacing: Adapt.setHeight(15),
                childAspectRatio: 1.5,
              ),
              shrinkWrap: true,
              children: [
                _buildAccountItem(
                  context,
                  "Admin",
                  false,
                  () {
                    context.goNamed("home");
                  },
                ),
                _buildAccountItem(
                  context,
                  "Patricia",
                  false,
                  () {
                    context.goNamed("home");
                  },
                ),
                _buildAccountItem(
                  context,
                  "Francis",
                  false,
                  () {
                    context.goNamed("home");
                  },
                ),
                _buildAccountItem(
                  context,
                  "Add user",
                  true,
                  () {
                    context.pushNamed("account-add");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountItem(
    BuildContext context,
    String name,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? AppTheme.of(context).primaryLight!
                    : AppTheme.of(context).txt!,
                width: 2,
              ),
            ),
            padding: EdgeInsets.all(Adapt.setRadius(35)),
            child: Text(
              name[0],
              style: TextStyles.h5.copyWith(
                color: isSelected
                    ? AppTheme.of(context).primaryLight!
                    : AppTheme.of(context).txt!,
              ),
            ),
          ),
          SizedBox(height: Adapt.setHeight(2)),
          Text(
            name,
            style: TextStyles.body2.copyWith(
              color: isSelected
                  ? AppTheme.of(context).primaryLight!
                  : AppTheme.of(context).txt!,
            ),
          ),
        ],
      ),
    );
  }
}
