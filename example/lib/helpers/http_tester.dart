import 'dart:async';
import 'dart:convert';

import 'package:shake_example/helpers/network_tester.dart';
import 'package:shake_http_client/shake_http_client.dart';

class HttpTester implements NetworkTester {
  ShakeHttpClient _httpClient;

  HttpTester() {
    _httpClient = ShakeHttpClient();
  }

  @override
  Future<void> sendGetRequest() async {
    await _httpClient.get(NetworkTester.GET_URL);
  }

  @override
  Future<void> sendPostRequest() async {
    var body = {"name": "test", "salary": "123", "age": "23"};
    await _httpClient.post(
      NetworkTester.POST_URL,
      body: jsonEncode(body),
    );
  }

  @override
  Future<void> sendGetFileRequest() async {
    ShakeHttpClient shakeHttpClient = ShakeHttpClient();
    await shakeHttpClient.get(NetworkTester.GET_FILE_URL);
  }

  @override
  Future<void> sendMultipartFileRequest() async {
    throw Exception("Send file requests tracking not supported for http");
  }

  @override
  Future<void> send404Request() async {
    await _httpClient.get(NetworkTester.ERROR_URL);
  }

  @override
  Future<void> sendTimeoutRequest() async {
    throw Exception("Timeout requests tracking not supported for http");
  }
}
