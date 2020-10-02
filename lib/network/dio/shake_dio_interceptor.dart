import 'package:dio/dio.dart';
import 'package:shake_flutter/models/network_request.dart';
import 'package:shake_flutter/shake_flutter.dart';
import 'package:shake_flutter/utils/extensions.dart';

class ShakeDioInterceptor extends Interceptor {
  static final Map<int, NetworkRequest> _requests = <int, NetworkRequest>{};

  @override
  Future onRequest(RequestOptions options) async {
    options.responseType = ResponseType.plain;

    final NetworkRequest data = NetworkRequest();
    data.startTime = DateTime.now();

    _requests[options.hashCode] = data;
  }

  @override
  Future onResponse(Response response) async {
    NetworkRequest networkRequest = _generateNetworkRequest(response);
    if (networkRequest != null) {
      Shake.insertNetworkRequest(networkRequest);
    }
  }

  @override
  Future onError(DioError e) async {
    NetworkRequest networkRequest = _generateNetworkRequest(e.response);
    if (networkRequest != null) {
      Shake.insertNetworkRequest(networkRequest);
    }
  }

  static NetworkRequest _getRequestData(int requestHashCode) {
    if (_requests[requestHashCode] != null) {
      return _requests.remove(requestHashCode);
    }
    return null;
  }

  NetworkRequest _generateNetworkRequest(Response response) {
    if (response == null) {
      return null;
    }

    final RequestOptions request = response.request;
    if (request == null) {
      return null;
    }

    final NetworkRequest networkRequest = _getRequestData(request.hashCode);
    if (networkRequest == null) {
      return null;
    }

    networkRequest.endTime = DateTime.now();
    networkRequest.url = request.uri.toString();
    networkRequest.method = request.method;
    networkRequest.status = response.statusCode;

    if (request.data != null) {
      String requestBody = request.data.toString();
      if (requestBody.isBinary()) {
        networkRequest.requestBody = "Binary data";
      } else {
        networkRequest.requestBody = requestBody;
      }
    }

    if (response.data != null) {
      String responseBody = response.data.toString();
      if (responseBody.isBinary()) {
        networkRequest.responseBody = "Binary data";
      } else {
        networkRequest.responseBody = responseBody;
      }
    }

    networkRequest.requestHeaders = Map<String, String>.from(request.headers);
    networkRequest.responseHeaders = _parseResponseHeaders(response.headers);

    return networkRequest;
  }

  Map<String, String> _parseResponseHeaders(Headers headers) {
    final Map<String, String> headersMap = <String, String>{};
    headers.forEach((name, value) {
      String joinedHeaders = value.join(";");
      headersMap.putIfAbsent(name, () => joinedHeaders);
    });
    return headersMap;
  }
}
