import 'package:shake_flutter/helpers/data_tracker.dart';
import 'package:shake_flutter/models/network_request.dart';
import 'package:shake_flutter/utils/extensions.dart';

typedef NetworkRequest NetworkRequestFilter(NetworkRequest networkRequest);

class NetworkTracker extends DataTracker {
  NetworkRequestFilter? filter;

  NetworkRequest filterNetworkRequest(NetworkRequest networkRequest) {
    if (filter != null) {
      networkRequest = filter!(networkRequest);
    }

    if (!networkRequest.url.isHttpUrl())  {
      networkRequest.url = 'https://not_a_valid_url';
    }

    return networkRequest;
  }
}
