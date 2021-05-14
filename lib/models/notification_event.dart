/// Shake report notification event.
class NotificationEvent {
  String id = '';
  String title = '';
  String description = '';

  Map<String, String> toMap() {
    Map<String, String> map = <String, String>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;

    return map;
  }

  static NotificationEvent fromMap(Map data) {
    NotificationEvent notificationEvent = NotificationEvent();
    notificationEvent.id = data['id'] ?? '';
    notificationEvent.description = data['description'] ?? '';
    notificationEvent.title = data["title"] ?? '';

    return notificationEvent;
  }
}
