typedef void UnreadMessagesListener(int count);

class Configuration {
  UnreadMessagesListener? unreadMessagesListener;
  Function? onShakeOpen;
  Function? onShakeDismiss;
  Function(String, Map<String, String>)? onShakeSubmit;
}
