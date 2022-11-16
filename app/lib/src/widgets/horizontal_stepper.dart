// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:magic/src/core/core.dart';

class HorizontalStepper extends StatefulWidget {
  final PageController controller;
  final List<String> options;
  final List<Widget> steps;
  final int initialPage;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? activeTextColor;
  final Color? inactiveTextColor;
  final String? title;
  final ScrollPhysics? physics;

  const HorizontalStepper({
    Key? key,
    required this.controller,
    required this.options,
    required this.steps,
    required this.initialPage,
    this.activeColor,
    this.inactiveColor,
    this.activeTextColor,
    this.inactiveTextColor,
    this.title,
    this.physics,
  })  : assert(options.length == steps.length),
        super(key: key);
  @override
  State<HorizontalStepper> createState() => _HorizontalStepperState();
}

class _HorizontalStepperState extends State<HorizontalStepper>
    with AutomaticKeepAliveClientMixin {
  PageController get _pageController => widget.controller;
  late int _currentPage;

  @override
  void initState() {
    _currentPage = widget.initialPage;
    _pageController.addListener(() {
      if (mounted) {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () async {
        // go back to previous pageview
        if (_currentPage > 0) {
          _pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: widget.title != null ? Text(widget.title!) : null,
                elevation: 0,
                backgroundColor: Colors.transparent,
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                expandedHeight: Adapt.setHeight(125),
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: Adapt.setWidth(15),
                          right: Adapt.setWidth(15),
                          bottom: Adapt.setHeight(18),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: widget.options.map((e) {
                                return Text(
                                  e,
                                  style: TextStyles.body3.copyWith(
                                    fontWeight: widget.options.indexOf(e) ==
                                            _currentPage
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: widget.options.indexOf(e) <=
                                            _currentPage
                                        ? widget.activeTextColor ??
                                            Theme.of(context).primaryColor
                                        : widget.inactiveTextColor ??
                                            Theme.of(context).disabledColor,
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: Adapt.setHeight(8)),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                LinearProgressIndicator(
                                  value:
                                      (_currentPage / widget.options.length) +
                                          (1 / widget.options.length),
                                  backgroundColor: AppTheme.of(context)
                                      .primaryLight
                                      ?.withOpacity(0.5),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    widget.activeColor ??
                                        Theme.of(context).primaryColor,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: widget.options.map((e) {
                                    return Container(
                                      height: 13,
                                      width: 13,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: widget.options.indexOf(e) <=
                                                  _currentPage
                                              ? widget.activeColor ??
                                                  Theme.of(context).primaryColor
                                              : widget.inactiveColor ??
                                                  Theme.of(context)
                                                      .disabledColor,
                                          width: 2,
                                        ),
                                        color: widget.options.indexOf(e) <=
                                                _currentPage
                                            ? AppTheme.of(context).primaryLight!
                                            : AppTheme.of(context).grey,
                                      ),
                                    );
                                  }).toList(),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ];
          },
          body: PageView(
            controller: _pageController,
            physics: widget.physics ?? const NeverScrollableScrollPhysics(),
            children: widget.steps,
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
