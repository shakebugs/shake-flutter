class NetworkRequest {
  String url;
  String method;
  dynamic requestBody = '';
  dynamic responseBody = '';
  int status;
  Map<String, dynamic> requestHeaders = <String, dynamic>{};
  Map<String, dynamic> responseHeaders = <String, dynamic>{};
  int duration;
  String contentType = '';
  DateTime endTime;
  DateTime startTime;
  String timestamp;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['url'] = url;
    map['method'] = method;
    map['status'] = status;
    map['requestBody'] = requestBody;
    map['responseBody'] = responseBody;
    map['requestHeaders'] = requestHeaders;
    map['responseHeaders'] = responseHeaders;
    map['contentType'] = contentType;
    map['duration'] = duration;
    map['timestamp'] = timestamp;

    return map;
  }
}
