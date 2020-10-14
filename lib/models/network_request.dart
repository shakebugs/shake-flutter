import 'package:shake_flutter/utils/extensions.dart';

/// Bug report network request.
class NetworkRequest {
  String url;
  String method;
  int status;
  String requestBody = '';
  String responseBody = '';
  Map<String, String> requestHeaders = <String, String>{};
  Map<String, String> responseHeaders = <String, String>{};
  DateTime _startTime;
  DateTime _endTime;
  int _duration;
  String _timestamp;

  get startTime {
    return _startTime;
  }

  set startTime(DateTime startTime) {
    _startTime = startTime;
    _adjustDuration();
    _adjustTimestamp();
  }

  get endTime {
    return _endTime;
  }

  set endTime(DateTime endTime) {
    _endTime = endTime;
    _adjustDuration();
  }

  get duration {
    return _duration;
  }

  get timestamp {
    return _timestamp;
  }

  _adjustDuration() {
    if (_startTime == null) return;
    if (_endTime == null) return;
    _duration = _endTime.difference(_startTime).inMilliseconds;
  }

  _adjustTimestamp() {
    _timestamp = _startTime.toIsoString();
  }

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
    map['timestamp'] = timestamp;

    return map;
  }
}
