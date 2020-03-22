import 'package:flutter_common_utils/http/http_manager.dart';
import 'package:flutter_test/flutter_test.dart';

/// @desc 测试
/// @time 2019-04-30 15:54
/// @author chenyun
void main() {
  test('httpManager.init', () {
    HttpManager().init(baseUrl: 'http://10.1.60.23:8001');
  });
}
