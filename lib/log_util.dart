/// @desc  日志输出
/// @time 2019/3/15 9:58 AM
/// @author Cheney
class LogUtil {
  static const String _TAG_DEFAULT = "###Lcfarm###";

  ///是否 debug
  static bool debug = false; //是否是debug模式,true: log v 不输出.

  static String tagDefault = _TAG_DEFAULT;

  static void init({bool isDebug = false, String tag = _TAG_DEFAULT}) {
    debug = isDebug;
    tag = tag;
  }

  static void e(Object object, {String tag}) {
    _printLog(tag, '  e  ', object);
  }

  static void v(Object object, {String tag}) {
    if (debug) {
      _printLog(tag, '  v  ', object);
    }
  }

  static void _printLog(String tag, String stag, Object object) {
    StringBuffer sb = StringBuffer();
    sb.write((tag == null || tag.isEmpty) ? tagDefault : tag);
    sb.write(stag);
    sb.write(object);
    print(sb.toString());
  }
}
