import 'package:flutter/material.dart';

/// @desc:屏幕适配
/// @time 2019/3/11 5:07 PM
/// @author Cheney
class LcfarmSize {
  static LcfarmSize instance = LcfarmSize();

  //设计稿的设备尺寸修改
  double width;
  double height;
  bool allowFontScaling;

  static MediaQueryData _mediaQueryData;
  static double _screenWidth;
  static double _screenHeight;
  static double _pixelRatio;
  static double _statusBarHeight;

  static double _bottomBarHeight;

  static double _textScaleFactor;

  LcfarmSize({
    this.width = 375,
    this.height = 677,
    this.allowFontScaling = false,
  });

  static LcfarmSize getInstance() {
    return instance;
  }

  void init(BuildContext context) {
    ///release 模式下取不到
//    _mediaQueryData = MediaQueryData.fromWindow(window);
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _mediaQueryData = mediaQuery;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = _mediaQueryData.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
//    print("lcfarm init _screenWidth=$_screenWidth");
//    print("lcfarm init _screenHeight=$_screenHeight");
//    print("lcfarm init _textScaleFactor=$_textScaleFactor");
//    print("lcfarm init scaleWidth=${_screenWidth / instance.width}");
  }

  static MediaQueryData get mediaQueryData => _mediaQueryData;

  ///每个逻辑像素的字体像素数，字体的缩放比例
  static double get textScaleFactory => _textScaleFactor;

  ///设备的像素密度
  static double get pixelRatio => _pixelRatio;

  ///当前设备宽度 dp
  static double get screenWidth => _screenWidth;

  ///当前设备高度 dp
  static double get screenHeight => _screenHeight;

  ///当前设备宽度 px
  static double get screenWidthPx => _screenWidth * _pixelRatio;

  ///当前设备高度 px
  static double get screenHeightPx => _screenHeight * _pixelRatio;

  ///状态栏高度 刘海屏会更高 dp
  static double get statusBarHeight => _statusBarHeight;

  ///底部安全区距离 dp
  static double get bottomBarHeight => _bottomBarHeight;

  ///状态栏高度 刘海屏会更高 px
  static double get statusBarHeightPx => _statusBarHeight * _pixelRatio;

  ///底部安全区距离 px
  static double get bottomBarHeightPx => _bottomBarHeight * _pixelRatio;

  ///根据屏幕宽度适配,实际的dp与设计稿px的比例
  static double get ratio => instance.scaleWidth;

  ///根据屏幕宽度适配,实际的dp与设计稿px的比例
  get scaleWidth => _screenWidth / instance.width;

  /// 根据设计稿的设备高度适配
  /// 当发现设计稿中的一屏显示的与当前样式效果不符合时,
  /// 或者形状有差异时,高度适配建议使用此方法
  /// 高度适配主要针对想根据设计稿的一屏展示一样的效果
  get scaleHeight => _screenHeight / instance.height;

  ///默认根据宽度适配
  static double dp(double width) => instance.setWidth(width);

  ///根据设计稿的设备宽度适配
  ///高度也根据这个来做适配可以保证不变形
  double setWidth(double width) => width * scaleWidth; //

  /// 高度也根据setWidth来做适配可以保证不变形(当你想要一个正方形的时候)
  ///setHeight方法主要是在高度上进行适配, 在你想控制UI上一屏的高度与实际中显示一样时使用.
  double setHeight(double height) => height * scaleHeight;

  ///字体大小适配方法
  static double sp(double fontSize) => instance.setSp(fontSize);

  ///字体大小适配方法,在 ios 中_textScaleFactor 不起作用
  ///@param fontSize 传入设计稿上字体的px ,
  ///@param allowFontScaling 控制字体是否要根据系统的“字体大小”辅助选项来进行缩放。默认值为true。
  ///@param allowFontScaling Specifies whether fonts should scale to respect Text Size accessibility settings. The default is true.
  double setSp(double fontSize) {
    return allowFontScaling
        ? setWidth(fontSize)
        : setWidth(fontSize) / _textScaleFactor;
  }
}
