import 'package:dio/dio.dart';
import 'package:shake_flutter/models/network_request.dart';
import 'package:shake_flutter/shake_flutter.dart';
import 'package:shake_flutter/utils/dates.dart';

class ShakeDioInterceptor extends Interceptor {
  static final Map<int, NetworkRequest> _requests = <int, NetworkRequest>{};

  @override
  Future<dynamic> onRequest(RequestOptions options) {
    DateTime startTime = DateTime.now();
    String startTimeString = Dates.formatISOTime(startTime);

    final NetworkRequest data = NetworkRequest();
    data.startTime = startTime;
    data.timestamp = startTimeString;
    _requests[options.hashCode] = data;
  }

  @override
  Future<dynamic> onResponse(Response response) {
    Shake.insertNetworkRequest(_map(response));
  }

  @override
  Future<dynamic> onError(DioError err) {
    Shake.insertNetworkRequest(_map(err.response));
  }

  static NetworkRequest _getRequestData(int requestHashCode) {
    if (_requests[requestHashCode] != null) {
      return _requests.remove(requestHashCode);
    }
    return null;
  }

  NetworkRequest _map(Response response) {
    final NetworkRequest data = _getRequestData(response.request.hashCode);
    data.endTime = DateTime.now();
    data.duration = data.endTime.millisecondsSinceEpoch -
        data.startTime.millisecondsSinceEpoch;
    final Map<String, dynamic> responseHeaders = <String, dynamic>{};
    response.headers.forEach((name, value) => responseHeaders[name] = value);
    data.url = response.request.uri.toString();
    data.method = response.request.method;
    data.requestBody = response.request.data;
    data.requestHeaders = response.request.headers;
    data.contentType = response.request.contentType.toString();
    data.status = response.statusCode;
    data.responseBody = response.data;
    data.responseHeaders = responseHeaders;

    return data;
  }
}
