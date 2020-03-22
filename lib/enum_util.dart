/// @desc 枚举工具类
/// @time 2019-09-17 17:11
/// @author Cheney
class EnumUtil {
  ///枚举格式化 String
  static String enumValueToString(Object o) => o.toString().split('.').last;

  ///String反显枚举
  static T enumValueFromString<T>(String key, List<T> values) =>
      values.firstWhere((v) => key == enumValueToString(v), orElse: () => null);
}
