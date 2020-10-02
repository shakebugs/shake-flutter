import 'dart:io';

import 'package:shake_flutter/models/network_request.dart';
import 'package:shake_flutter/utils/dates.dart';
import 'package:shake_flutter/shake_flutter.dart';

class ShakeHttpLogger {
  Map<int, NetworkRequest> requests = <int, NetworkRequest>{};

  NetworkRequest _getRequestData(int requestHashCode) {
    if (requests[requestHashCode] != null) {
      return requests.remove(requestHashCode);
    }
    return null;
  }

  void onRequest(HttpClientRequest request, {dynamic requestBody}) {
    final DateTime dateTime = DateTime.now();
    String stringDateTime = Dates.formatISOTime(dateTime);

    final NetworkRequest requestData = NetworkRequest();
    requestData.startTime = dateTime;
    requestData.timestamp = stringDateTime;
    requestData.method = request.method;
    requestData.url = request.uri.toString();
    request.headers.forEach((String header, dynamic value) {
      requestData.requestHeaders[header] = value[0];
    });
    if (requestBody != null) {
      requestData.requestBody = requestBody;
    }
    requests[request.hashCode] = requestData;
  }

  void onResponse(HttpClientResponse response, HttpClientRequest request,
      {dynamic responseBody}) {
    final DateTime endTime = DateTime.now();
    final NetworkRequest networkRequest = _getRequestData(request.hashCode);

    if (networkRequest == null) {
      return null;
    }

    networkRequest.status = response.statusCode;
    networkRequest.duration =
        endTime.difference(networkRequest.startTime).inMilliseconds;
    if (response.headers.contentType != null) {
      networkRequest.contentType = response.headers.contentType.value;
    }

    response.headers.forEach((String header, dynamic value) {
      networkRequest.responseHeaders[header] = value[0];
    });

    if (responseBody != null) {
      networkRequest.responseBody = responseBody;
    }

    Shake.insertNetworkRequest(networkRequest);
  }
}
