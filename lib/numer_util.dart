/// @desc 数字格式化
/// @time 2019-05-23 13:59
/// @author Cheney
class NumberUtil {
  /// 数字千位符，小数点，金额格式化
  /// @param num：传入数据
  /// @param point：小数位 默认为两位
  /// @param point：forcePoint 强制保留小数位
  static String formatNum(num, {point = 2, bool forcePoint = true}) {
    if (num != null && num != "null") {
      String str = double.parse(num.toString()).toString();

      // 分开截取
      List<String> sub = str.split('.');

      // 处理值
      List<String> val = [];
      if (sub.isNotEmpty) {
        val = List.from(sub[0].split(''));
      }
//      LogUtil.v("val=$val");
      // 处理点
      List<String> points = [];
      if (sub.length > 1) {
        points = List.from(sub[1].split(''));
      }
      //处理分割符
      for (int index = 0, i = val.length - 1; i >= 0; index++, i--) {
//        LogUtil.v("val index=$index i=$i ${val[i]} ");
        // 除以三没有余数、不等于零并且不等于1 就加个逗号
        if (index % 3 == 0 && index != 0) {
          val[i] = val[i] + ',';
        }
      }

//      // 处理小数点
      for (int i = 0; i <= point - points.length; i++) {
        points.add('0');
      }
      //如果大于长度就截取
      if (points.length > point) {
        // 截取数组
        points = points.sublist(0, point);
      }

      //去掉小数点后面的000
      // 判断是否有长度
      if (points.isNotEmpty &&
          (forcePoint || (!forcePoint && int.parse(points.join("")) > 0))) {
        return '${val.join('')}.${points.join('')}';
      } else {
        return val.join('');
      }
    } else {
      return "0.00";
    }
  }

  /// The parameter [fractionDigits] must be an integer satisfying: `0 <= fractionDigits <= 20`.
  static num getNumByValueStr(String valueStr, {int fractionDigits}) {
    double value = double.tryParse(valueStr);
    return fractionDigits == null
        ? value
        : getNumByValueDouble(value, fractionDigits);
  }

  /// The parameter [fractionDigits] must be an integer satisfying: `0 <= fractionDigits <= 20`.
  static num getNumByValueDouble(double value, int fractionDigits) {
    if (value == null) return null;
    String valueStr = value.toStringAsFixed(fractionDigits);
    return fractionDigits == 0
        ? int.tryParse(valueStr)
        : double.tryParse(valueStr);
  }

  /// get int by value str.
  static int getIntByValueStr(String valueStr) {
    return int.tryParse(valueStr);
  }

  /// get double by value str.
  static double getDoubleByValueStr(String valueStr) {
    return double.tryParse(valueStr);
  }

  /// get int by value object.
  static int getIntByValueObj(Object valueObj) {
    if (valueObj == null) {
      return 0;
    }
    return int.tryParse(valueObj.toString());
  }

  /// get double by value object.
  static double getDoubleByValueObj(Object valueObj) {
    if (valueObj == null) {
      return 0.00;
    }
    return double.tryParse(valueObj.toString());
  }
}
