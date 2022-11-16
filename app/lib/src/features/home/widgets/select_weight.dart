// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:magic/src/core/core.dart';
import 'package:magic/src/features/home/cubit/list%20workout/list_workout_cubit.dart';
import 'package:magic/src/features/home/model/create_workout_request.dart';
import 'package:magic/src/widgets/button_loading.dart';

class SelectWeights extends StatefulWidget {
  final CreateWorkoutRequest createWorkoutRequest;
  final PageController pageController;
  const SelectWeights({
    Key? key,
    required this.createWorkoutRequest,
    required this.pageController,
  }) : super(key: key);

  @override
  State<SelectWeights> createState() => _SelectWeightsState();
}

class _SelectWeightsState extends State<SelectWeights> {
  final _globalKey = GlobalKey<FormState>();
  final TextEditingController _weightController = TextEditingController();

  @override
  void initState() {
    _weightController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListWorkoutCubit, ListWorkoutState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          success: (_, __, message) {
            if (message != null) {
              if (message.contains("success")) {
                // go to the next page
                widget.pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            }
          },
        );
      },
      builder: (context, state) {
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
                "Select weights",
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
                "Please enter the weights you want to use for each excercise",
                style: TextStyles.body3.copyWith(
                  color: AppTheme.of(context).grey,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(
              height: Adapt.setHeight(30),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Adapt.setWidth(20),
              ),
              child: Form(
                key: _globalKey,
                child: TextFormField(
                  autofocus: true,
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Weight in lbs',
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
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppTheme.of(context).surface!,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a weight';
                    }
                    return null;
                  },
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
                  minimumSize: const Size(
                    double.infinity,
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
                onPressed: _weightController.text.isEmpty
                    ? null
                    : () async {
                        // close keyboard
                        FocusScope.of(context).unfocus();
                        try {
                          // validate form
                          if (_globalKey.currentState!.validate()) {
                            final weight = num.parse(_weightController.text);
                            final request =
                                widget.createWorkoutRequest.copyWith(
                              weight: weight,
                            );
                            context.read<ListWorkoutCubit>().createWorkout(
                                  request: request,
                                );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please enter a valid number",
                                style: TextStyles.body3.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: AppTheme.of(context).error,
                            ),
                          );
                        }
                      },
                child: state.maybeWhen(
                  orElse: () => const Text("PROCEED"),
                  success: (isLoading, workoutResponse, message) {
                    if (isLoading == true) {
                      return const ButtonLoading();
                    } else {
                      return const Text("PROCEED");
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
