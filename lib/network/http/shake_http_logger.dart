import 'package:http/http.dart' as http;
import 'package:shake_flutter/models/network_request.dart';
import 'package:shake_flutter/shake_flutter.dart';
import 'package:shake_flutter/utils/extensions.dart';

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
    networkRequest.startTime = startTime;
    networkRequest.endTime = DateTime.now();
    networkRequest.url = request.url.toString();
    networkRequest.method = request.method;
    networkRequest.status = response.statusCode;

    if (request.body != null) {
      if (request.body.isBinary()) {
        networkRequest.requestBody = "Binary data";
      } else {
        networkRequest.requestBody = request.body;
      }
    }

    if (response.body != null) {
      if (response.body.isBinary()) {
        networkRequest.responseBody = "Binary data";
      } else {
        networkRequest.responseBody = response.body;
      }
    }

    request.headers.forEach((header, value) {
      networkRequest.requestHeaders[header] = value;
    });

    response.headers.forEach((header, value) {
      networkRequest.responseHeaders[header] = value;
    });

    // Save network request
    Shake.insertNetworkRequest(networkRequest);
  }
}
