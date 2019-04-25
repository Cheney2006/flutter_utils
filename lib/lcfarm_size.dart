import 'dart:ui';

import 'package:flutter/material.dart';

/// @desc 屏幕适配
/// @time 2019/3/11 4:48 PM
/// @author chenyun

class LcfarmSize {
  static const initWidth = 375;

  static MediaQueryData _mediaQuery = MediaQueryData.fromWindow(window);

  static double _screenWidth = _mediaQuery.size.width;
  static double _screenHeight = _mediaQuery.size.height;
  static double _statusBarHeight = _mediaQuery.padding.top;
  static double _bottomBarHeight = _mediaQuery.padding.bottom;
  static double _pixelRatio = _mediaQuery.devicePixelRatio;

  static double _textScaleFactor = _mediaQuery.textScaleFactor;

  static bool _allowFontScaling = false;

  ///实际的dp与设计稿px的比例
  static double _ratio;

  static init(int number) {
    int uiWidth = number is int ? number : initWidth;
    _ratio = _screenWidth / uiWidth;
  }

  static MediaQueryData get mediaQueryData => _mediaQuery;

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

  ///状态栏高度 刘海屏会更高
  static double get statusBarHeight => _statusBarHeight * _pixelRatio;

  ///底部安全区距离
  static double get bottomBarHeight => _bottomBarHeight * _pixelRatio;

  ///实际的dp与设计稿px的比例
  static double get ratio => _ratio;

  ///根据设计稿的设备宽度适配
  ///高度也根据这个来做适配可以保证不变形
  static double dp(double size) {
    if (!(_ratio != null && _ratio > 0)) {
      LcfarmSize.init(initWidth);
    }
    return size * _ratio;
  }

//  static double px(int size) {
//    return size / _pixelRatio;
//  }

//  static setWidth(int width) => width * _ratio;

  /// 根据设计稿的设备高度适配
  /// 当发现设计稿中的一屏显示的与当前样式效果不符合时,
  /// 或者形状有差异时,高度适配建议使用此方法
  /// 高度适配主要针对想根据设计稿的一屏展示一样的效果
//  static setHeight(int height) => height * _ratio;

  ///字体大小适配方法
  ///@param fontSize 传入设计稿上字体的px ,
  ///@param allowFontScaling 控制字体是否要根据系统的“字体大小”辅助选项来进行缩放。默认值为true。
  ///@param allowFontScaling Specifies whether fonts should scale to respect Text Size accessibility settings. The default is true.
  static double sp(double fontSize) =>
      _allowFontScaling ? dp(fontSize) : dp(fontSize) / _textScaleFactor;
}
