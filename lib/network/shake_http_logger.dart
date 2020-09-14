import 'package:http/http.dart' as http;
import 'package:shake_flutter/models/network_request.dart';
import 'package:shake_flutter/shake_flutter.dart';

class ShakeHttpLogger {
  void logHttpResponse(http.Response response, {DateTime startTime}) {
    if (response == null) {
      return;
    }

    http.Request request = response.request;
    if (request == null) {
      return;
    }

    NetworkRequest networkRequest = NetworkRequest();

    // Request
    networkRequest.url = request.url.toString();
    networkRequest.method = request.method;
    if (request.body != null) {
      networkRequest.requestBody = request.body;
    }

    request.headers.forEach((header, value) {
      networkRequest.requestHeaders[header] = value;
    });

    // Response
    networkRequest.status = response.statusCode;
    response.headers.forEach((header, value) {
      networkRequest.responseHeaders[header] = value;
    });

    if (response.body != null) {
      networkRequest.responseBody = response.body;
    }
    if (response.headers.containsKey('content-type')) {
      networkRequest.contentType = response.headers['content-type'];
    }

    networkRequest.timestamp = startTime.toIso8601String();
    networkRequest.duration =
        DateTime.now().difference(startTime).inMilliseconds;

    Shake.insertNetworkRequest(networkRequest);
  }
}
