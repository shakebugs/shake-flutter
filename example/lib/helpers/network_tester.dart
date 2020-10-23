abstract class NetworkTester {
  static const String GET_URL = 'https://dummy.restapiexample.com/api/v1/employees';
  static const String POST_URL = 'https://postman-echo.com/post';
  static const String ERROR_URL = 'https://run.mocky.io/v3/267ed439-8ea6-4495-bda7-90969e039a9e';
  static const String TIMEOUT_URL = 'https://postman-echo.com/post';
  static const String POST_FILE_URL = 'https://httpbin.org/response-headers';
  static const String GET_FILE_URL = 'https://4.img-dpreview.com/files/p/E~TS590x0~articles/3925134721/0266554465.jpeg';

  Future<void> sendGetRequest();

  Future<void> sendPostRequest();

  Future<void> sendGetFileRequest();

  Future<void> sendPostFileRequest();

  Future<void> send404Request();

  Future<void> sendTimeoutRequest();
}
