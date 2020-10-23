import 'dart:io';

import 'package:shake_flutter/models/network_request.dart';
import 'package:shake_flutter/shake_flutter.dart';
import 'package:shake_flutter/utils/extensions.dart';

/// Parser and logger for dart:io network requests.
class ShakeHttpLogger {
  Map<int, NetworkRequest> _requests = <int, NetworkRequest>{};

  void onRequest(
    HttpClientRequest request, {
    String requestBody,
  }) {
    final NetworkRequest networkRequest = NetworkRequest();
    networkRequest.startTime = DateTime.now();
    networkRequest.method = request.method;
    networkRequest.url = request.uri.toString();

    if (requestBody != null) {
      if (requestBody.isBinary()) {
        networkRequest.requestBody = "Binary data";
      } else {
        networkRequest.requestBody = requestBody;
      }
    }

    request.headers.forEach((String header, dynamic value) {
      networkRequest.requestHeaders[header] = value[0].toString();
    });

    _requests[request.hashCode] = networkRequest;
  }

  void onResponse(
    HttpClientResponse response,
    HttpClientRequest request, {
    String responseBody,
  }) {
    final NetworkRequest networkRequest = _getRequestData(request.hashCode);
    if (networkRequest == null) {
      return null;
    }

    networkRequest.endTime = DateTime.now();
    networkRequest.status = response.statusCode.toString();

    if (responseBody != null) {
      if (responseBody.isBinary()) {
        networkRequest.responseBody = "Binary data";
      } else {
        networkRequest.responseBody = responseBody;
      }
    }

    response.headers.forEach((String header, dynamic value) {
      networkRequest.responseHeaders[header] = value[0].toString();
    });

    Shake.insertNetworkRequest(networkRequest);
  }

  NetworkRequest _getRequestData(int requestHashCode) {
    if (_requests[requestHashCode] != null) {
      return _requests.remove(requestHashCode);
    }
    return null;
  }
}
