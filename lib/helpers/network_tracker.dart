import 'package:shake_flutter/helpers/data_tracker.dart';
import 'package:shake_flutter/models/network_request.dart';

typedef NetworkRequest NetworkRequestFilter(NetworkRequest networkRequest);

class NetworkTracker extends DataTracker {
  NetworkRequestFilter? filter;

  NetworkRequest filterNetworkRequest(NetworkRequest networkRequest) {
    if (filter != null) {
      NetworkRequest filteredRequest = filter!(networkRequest);
      return filteredRequest;
    }

    return networkRequest;
  }
}
