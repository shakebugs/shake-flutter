import 'package:shake_flutter/models/shake_base_action.dart';

typedef void UnreadMessagesListener(int count);

class Configuration {
  UnreadMessagesListener? unreadMessagesListener;
  Function? onShakeOpen;
  Function? onShakeDismiss;
  Function(String, Map<String, String>)? onShakeSubmit;
  List<ShakeBaseAction>? homeActions;
}
