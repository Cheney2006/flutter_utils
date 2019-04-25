import 'package:dio/dio.dart';

/// @desc  网络请求错误
/// @time 2019/3/20 10:02 AM
/// @author chenyun
class HttpError {
  ///HTTP 状态码
  static const int UNAUTHORIZED = 401;
  static const int FORBIDDEN = 403;
  static const int NOT_FOUND = 404;
  static const int REQUEST_TIMEOUT = 408;
  static const int INTERNAL_SERVER_ERROR = 500;
  static const int BAD_GATEWAY = 502;
  static const int SERVICE_UNAVAILABLE = 503;
  static const int GATEWAY_TIMEOUT = 504;

  ///未知错误
  static const int UNKNOWN = -9999999;

  ///解析错误
  static const int PARSE_ERROR = -9999998;

  ///网络错误
  static const int NETWORK_ERROR = -9999997;

  ///协议错误
  static const int HTTP_ERROR = -9999996;

  ///证书错误
  static const int SSL_ERROR = -9999995;

  ///连接超时
  static const int CONNECT_TIMEOUT = -9999994;

  ///响应超时
  static const int RECEIVE_TIMEOUT = -9999993;

  ///发送超时
  static const int SEND_TIMEOUT = -9999992;

  ///网络请求取消
  static const int CANCEL = -9999991;

  int code;

  String message;

  HttpError(this.code, this.message);

  HttpError.DioError(DioError error) {
    message = error.message;
    switch (error.type) {
      case DioErrorType.CONNECT_TIMEOUT:
//        code = CONNECT_TIMEOUT;
//        break;
      case DioErrorType.RECEIVE_TIMEOUT:
//        code = RECEIVE_TIMEOUT;
//        break;
      case DioErrorType.SEND_TIMEOUT:
//        code = SEND_TIMEOUT;
//        break;
      case DioErrorType.RESPONSE:
        code = HTTP_ERROR;
        break;
      case DioErrorType.CANCEL:
        code = CANCEL;
        break;
      case DioErrorType.DEFAULT:

        ///todo 解析出网络导常 NETWORK_ERROR
        code = UNKNOWN;
        break;
    }
  }

  @override
  String toString() {
    return 'HttpError{code: $code, message: $message}';
  }
}
