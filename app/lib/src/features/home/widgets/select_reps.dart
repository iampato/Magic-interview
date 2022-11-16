import 'package:flutter/material.dart';
import 'package:magic/src/core/core.dart';

class SelectSetAndReps extends StatefulWidget {
  final PageController pageController;
  final Function(int sets, int reps) onSelected;
  const SelectSetAndReps({
    Key? key,
    required this.pageController,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<SelectSetAndReps> createState() => _SelectSetAndRepsState();
}

class _SelectSetAndRepsState extends State<SelectSetAndReps> {
  final _globalKey = GlobalKey<FormState>();
  final TextEditingController _setsController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();

  @override
  void initState() {
    _setsController.addListener(() {
      setState(() {});
    });
    _repsController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _setsController.dispose();
    _repsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: Adapt.setWidth(20),
              right: Adapt.setWidth(20),
              top: Adapt.setHeight(20),
            ),
            child: Text(
              "Select sets and reps",
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
              "Please enter the number of sets and reps you want to for this workout",
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
            child: TextFormField(
              autofocus: true,
              controller: _setsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Number of sets e.g 3',
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
                  return 'Please enter the number of sets';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: Adapt.setHeight(10)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Adapt.setWidth(20),
            ),
            child: TextFormField(
              autofocus: true,
              controller: _repsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Number of reps e.g 8',
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
              onPressed: _setsController.text.isEmpty
                  ? null
                  : () async {
                      // close keyboard
                      FocusScope.of(context).unfocus();
                      try {
                        // validate form
                        if (_globalKey.currentState!.validate()) {
                          // if _repsController.text.isEmpty
                          // then set reps to 1
                          if (_repsController.text.isEmpty) {
                            _repsController.text = "1";
                          }
                          widget.onSelected(
                            int.parse(_setsController.text),
                            int.parse(_repsController.text),
                          );
                          // go to the next page
                          widget.pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
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
              child: const Text("PROCEED"),
            ),
          ),
        ],
      ),
    );
  }
}
