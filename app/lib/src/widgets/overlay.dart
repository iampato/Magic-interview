import 'package:flutter/material.dart';

class ActivityOverlay {
  bool _isVisible = false;

  BuildContext context;
  Widget? child;

  OverlayState? overlayState;
  late OverlayEntry overlayEntry;

  ActivityOverlay(this.context, Widget child) {
    overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (context) => child,
    );
  }

  void show() async {
    if (_isVisible) return;

    _isVisible = true;

    overlayState!.insert(overlayEntry);
  }

  bool isOpened() {
    return _isVisible;
  }

  void remove() async {
    if (!_isVisible) return;

    _isVisible = false;

    overlayEntry.remove();
  }
}
