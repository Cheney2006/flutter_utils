import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common_utils/http/http_error.dart';
import 'package:flutter_common_utils/http/lcfarm_log_interceptor.dart';
import 'package:flutter_common_utils/log_util.dart';

/// @desc  封装 http 请求
/// @time 2019/3/15 10:35 AM
/// @author chenyun
class HttpManager {
  ///同一个CancelToken可以用于多个请求，当一个CancelToken取消时，所有使用该CancelToken的请求都会被取消，一个页面对应一个CancelToken。
  Map<String, CancelToken> _cancelTokens = new Map<String, CancelToken>();

  ///超时时间
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 30000;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';

  Dio _client;

  static final HttpManager _instance = HttpManager._internal();

  factory HttpManager() => _instance;

  Dio get client => _client;

  /// 创建 dio 实例对象
  HttpManager._internal() {
    if (_client == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      BaseOptions options = new BaseOptions(
//        baseUrl: Api.API_PREFIX,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      );
      _client = Dio(options);

      _client.interceptors..add(LcfarmLogInterceptor());
    }
  }

  ///初始化公共属性
  ///
  /// [baseUrl] 地址前缀
  /// [connectTimeout] 连接超时赶时间
  /// [receiveTimeout] 接收超时赶时间
  /// [interceptors] 基础拦截器
  void init(
      {String baseUrl,
      int connectTimeout,
      int receiveTimeout,
      List<Interceptor> interceptors}) {
    if (baseUrl != null) {
      _client.options.baseUrl = baseUrl;
    }
    if (connectTimeout != null) {
      _client.options.connectTimeout = connectTimeout;
    }
    if (receiveTimeout != null) {
      _client.options.receiveTimeout = receiveTimeout;
    }
    if (interceptors != null && interceptors.length > 0) {
      _client.interceptors..addAll(interceptors);
    }
  }

  ///统一网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[tag] 请求统一标识，用于取消网络请求
  void request({
    @required String url,
    method,
    params,
    Options options,
    HttpSuccessCallback successCallback,
    HttpFailureCallback errorCallback,
    @required String tag,
  }) async {
    //设置默认值
    params = params ?? {};
    method = method ?? 'GET';

    options?.method = method;

    options = options ??
        Options(
          method: method,
        );

    // restful 请求处理
    // /gysw/search/hist/:user_id        user_id=27
    // 最终生成 url 为     /gysw/search/hist/27
    params.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });

    try {
      CancelToken cancelToken;
      if (tag != null) {
        cancelToken =
            _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
        _cancelTokens[tag] = cancelToken;
      }

      Response<Map<String, dynamic>> response = await _client.request(url,
          data: params, options: options, cancelToken: cancelToken);

      if (successCallback != null) {
        successCallback(response);
      }

      //直接取出 code 判断
//      BaseResponse baseResponse = BaseResponse(response.data, buildFun);
//      if (baseResponse.isOk) {
//        if (callback != null) {
//          callback(response.data);
//        }
//      } else {
//        _handlerError(errorCallback, null);
//      }
    } on DioError catch (e) {
      if (errorCallback != null && e.type != DioErrorType.CANCEL) {
        errorCallback(HttpError.DioError(e));
      }
      LogUtil.v("请求出错：$e");
    } catch (e) {
      //单独运行时取 cookie 报无法找到第三方错
      if (errorCallback != null) {
        errorCallback(HttpError(HttpError.UNKNOWN, e.toString()));
      }
      LogUtil.v("请求出错：$e");
    }
  }

  /// todo 合并请求
  /// 下载文件
  /// 上传文件
  ///

  ///取消网络请求
  void cancelHttp(String tag) {
    if (_cancelTokens.containsKey(tag)) {
      if (!_cancelTokens[tag].isCancelled) {
        _cancelTokens[tag].cancel();
      }
      _cancelTokens.remove(tag);
    }
  }
}

///http请求成功回调
typedef HttpSuccessCallback<T> = void Function(
    Response<Map<String, dynamic>> data);

///失败回调
typedef HttpFailureCallback = void Function(HttpError data);
