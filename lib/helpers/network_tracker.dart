import 'package:shake_flutter/models/network_request.dart';

typedef NetworkRequest NetworkRequestFilter(NetworkRequest networkRequest);

class NetworkTracker {
  NetworkRequestFilter? filter;

  NetworkRequest filterNetworkRequest(NetworkRequest networkRequest) {
    if (filter != null) networkRequest = filter!(networkRequest);
    return networkRequest;
  }
}
