import 'dart:convert';
import 'dart:io';

import 'package:shake_example/helpers/network_tester.dart';
import 'package:shake_flutter/network/shake_http_logger.dart';

class DartTester implements NetworkTester {
  ShakeHttpLogger _httpLogger = ShakeHttpLogger();

  @override
  Future<void> sendGetRequest() async {
    HttpClient httpclient = HttpClient();
    HttpClientRequest request = await httpclient.getUrl(
      Uri.parse(NetworkTester.GET_URL),
    );

    _httpLogger.onRequest(request);

    HttpClientResponse response = await request.close();
    String responseBody;
    try {
      responseBody = await response.transform(utf8.decoder).join();
    } catch (e) {
      responseBody = "Binary data";
    }

    _httpLogger.onResponse(
      request,
      response,
      responseBody: responseBody,
    );
  }

  @override
  Future<void> sendPostRequest() async {
    var data = {"name": "test", "salary": "123", "age": "23"};
    String requestBody = jsonEncode(data);

    HttpClient httpclient = HttpClient();
    HttpClientRequest request = await httpclient.postUrl(
      Uri.parse(NetworkTester.POST_URL),
    );
    request.headers.contentLength = requestBody.length;
    request.write(requestBody);

    _httpLogger.onRequest(
      request,
      requestBody: requestBody,
    );

    HttpClientResponse response = await request.close();
    String responseBody;
    try {
      responseBody = await response.transform(utf8.decoder).join();
    } catch (e) {
      responseBody = "Binary data";
    }

    _httpLogger.onResponse(
      request,
      response,
      responseBody: responseBody,
    );
  }

  @override
  Future<void> sendGetFileRequest() async {
    HttpClient httpclient = HttpClient();
    HttpClientRequest request = await httpclient.getUrl(
      Uri.parse(NetworkTester.GET_FILE_URL),
    );

    _httpLogger.onRequest(request);

    HttpClientResponse response = await request.close();
    String responseBody;
    try {
      responseBody = await response.transform(utf8.decoder).join();
    } catch (e) {
      responseBody = "Binary data";
    }

    _httpLogger.onResponse(request, response, responseBody: responseBody);
  }

  @override
  Future<void> sendMultipartFileRequest() async {
    throw Exception("Send file requests tracking not supported for dart:io");
  }

  @override
  Future<void> send404Request() async {
    var data = {"name": "test", "salary": "123", "age": "23"};
    String body = jsonEncode(data);

    HttpClient httpclient = HttpClient();
    HttpClientRequest request = await httpclient.postUrl(
      Uri.parse(NetworkTester.ERROR_URL),
    );
    request.headers.contentLength = body.length;
    request.write(body);

    _httpLogger.onRequest(
      request,
      requestBody: body,
    );

    HttpClientResponse response = await request.close();
    String responseBody;
    try {
      responseBody = await response.transform(utf8.decoder).join();
    } catch (e) {
      responseBody = "Binary data";
    }

    _httpLogger.onResponse(
      request,
      response,
      responseBody: responseBody,
    );
  }

  @override
  Future<void> sendTimeoutRequest() async {
    throw Exception("Timeout requests tracking not supported for dart:io");
  }
}
