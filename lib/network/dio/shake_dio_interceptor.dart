import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:shake_flutter/models/network_request.dart';
import 'package:shake_flutter/shake_flutter.dart';
import 'package:shake_flutter/utils/dates.dart';

class ShakeDioInterceptor extends Interceptor {
  static final Map<int, NetworkRequest> _requests = <int, NetworkRequest>{};

  @override
  Future onRequest(RequestOptions options) async {
    DateTime startTime = DateTime.now();

    final NetworkRequest data = NetworkRequest();
    data.startTime = startTime;
    data.timestamp = Dates.formatISOTime(startTime);

    _requests[options.hashCode] = data;
  }

  @override
  Future onResponse(Response response) async {
    Shake.insertNetworkRequest(_map(response));
  }

  @override
  Future onError(DioError err) async {
    Shake.insertNetworkRequest(_map(err.response));
  }

  static NetworkRequest _getRequestData(int requestHashCode) {
    if (_requests[requestHashCode] != null) {
      return _requests.remove(requestHashCode);
    }
    return null;
  }

  NetworkRequest _map(Response response) {
    int hashCode = response.request.hashCode;
    final NetworkRequest networkRequest = _getRequestData(hashCode);

    networkRequest.endTime = DateTime.now();
    networkRequest.duration = networkRequest.endTime.millisecondsSinceEpoch -
        networkRequest.startTime.millisecondsSinceEpoch;
    networkRequest.url = response.request.uri.toString();
    networkRequest.method = response.request.method;
    networkRequest.contentType = response.request.contentType.toString();
    networkRequest.status = response.statusCode;

    String requestBody = response.request.data;
    String responseBody = response.data.toString();

    networkRequest.requestBody = requestBody == null ? '' : requestBody;
    networkRequest.responseBody = responseBody == null ? '' : responseBody;

    networkRequest.requestHeaders = response.request.headers;
    networkRequest.responseHeaders = _parseHeaders(response.headers);

    return networkRequest;
  }

  Map<String, String> _parseHeaders(Headers headers) {
    final Map<String, String> headersMap = <String, String>{};
    headers.forEach((name, value) {
      String joinedHeaders = value.join(";");
      headersMap.putIfAbsent(name, () => joinedHeaders);
    });
    return headersMap;
  }
}
