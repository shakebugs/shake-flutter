import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shake_dio_interceptor/shake_dio_interceptor.dart';
import 'package:shake_example/helpers/network_tester.dart';
import 'package:shake_example/utils/files.dart';

class DioTester implements NetworkTester {
  Dio _dio;

  DioTester() {
    _dio = Dio();
    _dio.interceptors.add(ShakeDioInterceptor());
  }

  @override
  Future<void> sendGetRequest() async {
    await _dio.get(NetworkTester.GET_URL);
  }

  @override
  Future<void> sendGetFileRequest() async {
    await _dio.get(NetworkTester.GET_FILE_URL);
  }

  @override
  Future<void> sendPostFileRequest() async {
    File file = await Files.createDummyFile("tmp.txt");

    Options options = Options();
    options.headers["Content-Type"] = "multipart/form-data";

    FormData formData = new FormData.fromMap({
      'file': MultipartFile.fromBytes(
        await file.readAsBytes(),
        filename: "tmp.txt",
        contentType: MediaType("text", "plain"),
      )
    });

    await _dio.post(NetworkTester.POST_FILE_URL, data: formData);
  }

  @override
  Future<void> sendPostRequest() async {
    var body = {"name": "test", "salary": "123", "age": "23"};
    await _dio.post(
      NetworkTester.POST_URL,
      data: jsonEncode(body),
    );
  }

  @override
  Future<void> send404Request() async {
    await _dio.get(NetworkTester.ERROR_URL);
  }

  @override
  Future<void> sendTimeoutRequest() async {
    var body = {"name": "test", "salary": "123", "age": "23"};
    await _dio.post(
      NetworkTester.TIMEOUT_URL,
      data: jsonEncode(body),
      options: Options(receiveTimeout: 1),
    );
  }
}
