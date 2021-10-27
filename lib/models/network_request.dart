import 'package:shake_flutter/utils/extensions.dart';

/// Shake report network request.
class NetworkRequest {
  String url = '';
  String method = '';
  String status = '';
  String requestBody = '';
  String responseBody = '';
  Map<String, String> requestHeaders = <String, String>{};
  Map<String, String> responseHeaders = <String, String>{};
  int duration = 0;
  DateTime? startTime;
  DateTime? endTime;
  DateTime date = DateTime.now();

  /// Converts object to map.
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['url'] = url;
    map['method'] = method;
    map['status'] = status;
    map['requestBody'] = requestBody;
    map['responseBody'] = responseBody;
    map['requestHeaders'] = requestHeaders;
    map['responseHeaders'] = responseHeaders;
    map['duration'] = duration;
    map['timestamp'] = date.toIsoString();

    return map;
  }
}
