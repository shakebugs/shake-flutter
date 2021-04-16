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
    networkRequest.requestBody = _removeBinaryData(requestBody);
    request.headers.forEach((String header, dynamic value) {
      networkRequest.requestHeaders[header] = value[0].toString();
    });

    _requests[request.hashCode] = networkRequest;
  }

  void onResponse(
    HttpClientRequest request,
    HttpClientResponse response, {
    String responseBody,
  }) async {
    final NetworkRequest networkRequest = _getRequestData(request.hashCode);
    if (networkRequest == null) {
      return null;
    }

    networkRequest.endTime = DateTime.now();
    networkRequest.status = response.statusCode.toString();
    networkRequest.responseBody = _removeBinaryData(responseBody);
    response.headers.forEach((String header, dynamic value) {
      networkRequest.responseHeaders[header] = value[0].toString();
    });

    Shake.insertNetworkRequest(networkRequest);
  }

  String _removeBinaryData(String text) {
    if (text == null) return "";

    if (text.isBinary()) {
      return "Binary data";
    }

    return text;
  }

  NetworkRequest _getRequestData(int requestHashCode) {
    if (_requests[requestHashCode] != null) {
      return _requests.remove(requestHashCode);
    }
    return null;
  }
}
