import 'package:flutter_screenutil/flutter_screenutil.dart';

class Adapt {
  static double? get _width => ScreenUtil().screenWidth;
  static double? get _height => ScreenUtil().screenHeight;
  static double? get _topbarH => ScreenUtil().statusBarHeight;
  static double? get _botbarH => ScreenUtil().bottomBarHeight;
  static double get _pixelRatio => ScreenUtil().pixelRatio!;

  static double onepx() {
    return 1 / _pixelRatio;
  }

  static double sp(num number) {
    return ScreenUtil().setSp(number);
  }

  static double setWidth(num number) {
    return ScreenUtil().setWidth(number);
  }

  static double setHeight(num number) {
    return ScreenUtil().setHeight(number);
  }

  static double setRadius(num number) {
    return ScreenUtil().radius(number);
  }

  static double screenW() {
    return _width!;
  }

  static double screenH() {
    return _height!;
  }

  static double padTopH() {
    return _topbarH!;
  }

  static double padBotH() {
    return _botbarH!;
  }
}