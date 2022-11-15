import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:magic/src/core/core.dart';
import 'package:magic/src/features/landing/cubit/authentication/authentication_cubit.dart';
import 'package:magic/src/features/onboarding/cubit/login/login_cubit.dart';
import 'package:magic/src/features/onboarding/widgets/custom_text_button.dart';
import 'package:magic/src/widgets/button_loading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _globalFormKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _viewPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {},
            success: (response) {
              context
                  .read<AuthenticationCubit>()
                  .authenticateUser(response.user);
              context.goNamed('home');
            },
            error: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error),
                  backgroundColor: AppTheme.of(context).error,
                ),
              );
            },
          );
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: Adapt.setWidth(25),
            ),
            child: Form(
              key: _globalFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Adapt.screenH() * 0.05),
                  Padding(
                    padding: EdgeInsets.only(left: Adapt.setWidth(2)),
                    child: Text(
                      'Sign in to continue'.toUpperCase(),
                      style: TextStyles.h5.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(height: Adapt.setHeight(35)),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
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
                    onSaved: (newValue) {
                      setState(() {
                        _email = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      }
                      // regex validate email
                      bool isValidEmail =
                          RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                      if (!isValidEmail) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Adapt.setHeight(10)),
                  TextFormField(
                    obscureText: _viewPassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: AppTheme.of(context).surface,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _viewPassword = !_viewPassword;
                          });
                        },
                        icon: !_viewPassword
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
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
                    onSaved: (newValue) {
                      setState(() {
                        _password = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a strong password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Adapt.setHeight(22)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomTextButton(
                        onPressed: () {
                          context.pushNamed("forgot");
                        },
                        text: 'Forgot Password?',
                      ),
                    ],
                  ),
                  SizedBox(height: Adapt.setHeight(5)),
                  ElevatedButton(
                    onPressed: () async {
                      // close keyboard
                      FocusScope.of(context).unfocus();
                      // validate the input data
                      // submit it
                      if (_globalFormKey.currentState!.validate()) {
                        _globalFormKey.currentState!.save();
                        await context.read<LoginCubit>().loginUser(
                              emailAddress: _email,
                              password: _password,
                            );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("data is invalid")),
                        );
                      }
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
                    child: state.maybeWhen(
                      orElse: () => Text(
                        "Login".toUpperCase(),
                        style: TextStyles.body1,
                      ),
                      loading: () => const ButtonLoading(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
