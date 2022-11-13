import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magic/src/core/core.dart';
import 'package:magic/src/features/onboarding/widgets/custom_text_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                'Sign up to continue'.toUpperCase(),
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
            SizedBox(height: Adapt.setHeight(10)),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomTextButton(
                  onPressed: () {},
                  text: 'Already have an account?',
                ),
              ],
            ),
            SizedBox(height: Adapt.setHeight(5)),
            ElevatedButton(
              onPressed: () {},
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
                "Sign up".toUpperCase(),
                style: TextStyles.body1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
