import 'package:shake_flutter/models/notification_event.dart';

typedef NotificationEvent NotificationEventFilter(
    NotificationEvent notificationEvent);

class NotificationsTracker {
  NotificationEventFilter? filter;

  NotificationEvent filterNotificationEvent(
      NotificationEvent notificationEvent) {
    if (filter != null) {
      notificationEvent = filter!(notificationEvent);
    }

    return notificationEvent;
  }
}
