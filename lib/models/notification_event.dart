/// Shake report notification event.
class NotificationEvent {
  int id = 0;
  String title = "";
  String description = "";

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;

    return map;
  }

  static NotificationEvent fromMap(Map data) {
    NotificationEvent notificationEvent = NotificationEvent();
    notificationEvent.id = int.parse(data["id"]);
    notificationEvent.description = data["description"];
    notificationEvent.title = data["title"];

    return notificationEvent;
  }
}
