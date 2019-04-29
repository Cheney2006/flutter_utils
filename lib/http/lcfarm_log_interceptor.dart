import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter_common_utils/log_util.dart';

/// @desc  自定义日志拦截器
///@time 2019/3/18 9:15 AM
/// @author chenyun
class LcfarmLogInterceptor extends Interceptor {
  LcfarmLogInterceptor({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = true,
    this.responseHeader = true,
    this.responseBody = true,
    this.error = true,
    this.logSize = 2048,
  });

  /// Print request [Options]
  bool request;

  /// Print request header [Options.headers]
  bool requestHeader;

  /// Print request data [Options.data]
  bool requestBody;

  /// Print [Response.data]
  bool responseBody;

  /// Print [Response.headers]
  bool responseHeader;

  /// Print error message
  bool error;

  /// Log size per print
  final logSize;

  @override
  onRequest(RequestOptions options) {
    LogUtil.v('*** Request ***');
    printKV('uri', options.uri);

    if (request) {
      printKV('method', options.method);
      printKV('contentType', options.contentType.toString());
      printKV('responseType', options.responseType.toString());
      printKV('followRedirects', options.followRedirects);
      printKV('connectTimeout', options.connectTimeout);
      printKV('receiveTimeout', options.receiveTimeout);
      printKV('extra', options.extra);
    }
    if (requestHeader) {
      StringBuffer stringBuffer = new StringBuffer();
      options.headers.forEach(
          (key, v) => stringBuffer.write('\n${LogUtil.tagDefault} $key:$v'));
      printKV('header', stringBuffer.toString());
      stringBuffer.clear();
    }
    if (requestBody) {
      LogUtil.v("data:");
      printAll(options.data);
    }
    LogUtil.v("");
  }

  @override
  onError(DioError err) {
    if (error) {
      LogUtil.v('*** DioError ***:');
      LogUtil.v(err);
      if (err.response != null) {
        _printResponse(err.response);
      }
    }
  }

  @override
  onResponse(Response response) {
    LogUtil.v("*** Response ***");
    _printResponse(response);
  }

  void _printResponse(Response response) {
    printKV('uri', response.request.uri);
    if (responseHeader) {
      printKV('statusCode', response.statusCode);
      if (response.isRedirect) printKV('redirect', response.realUri);
      LogUtil.v("headers:");
      LogUtil.v("" + response.headers.toString().replaceAll("\n", "\n "));
    }
    if (responseBody) {
      LogUtil.v("Response Text:");
      printAll(response.toString());
    }
    LogUtil.v("");
  }

  printKV(String key, Object v) {
    LogUtil.v('$key: $v');
  }

  printAll(msg) {
    msg.toString().split("\n").forEach(_printAll);
  }

  _printAll(String msg) {
    int groups = (msg.length / logSize).ceil();
    for (int i = 0; i < groups; ++i) {
      LogUtil.v((i > 0 ? '<<Log follows the previous line: ' : '') +
          msg.substring(
              i * logSize, math.min<int>(i * logSize + logSize, msg.length)));
    }
  }
}
