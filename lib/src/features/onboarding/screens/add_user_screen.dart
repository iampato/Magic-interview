import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magic/src/core/core.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
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
                'Add user'.toUpperCase(),
                style: TextStyles.h5.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(height: Adapt.setHeight(35)),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Full name',
                filled: true,
                fillColor: AppTheme.of(context).surface,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Adapt.setWidth(15),
                  vertical: Adapt.setHeight(18),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppTheme.of(context).surface!,
                  ),
                ),
              ),
            ),
            SizedBox(height: Adapt.setHeight(10)),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email Address',
                filled: true,
                fillColor: AppTheme.of(context).surface,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Adapt.setWidth(15),
                  vertical: Adapt.setHeight(18),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppTheme.of(context).surface!,
                  ),
                ),
              ),
            ),
            SizedBox(height: Adapt.setHeight(22)),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                  double.infinity,
                  Adapt.setHeight(55),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: Corners.s20Border,
                ),
              ),
              child: Text(
                "Add".toUpperCase(),
                style: TextStyles.body1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
