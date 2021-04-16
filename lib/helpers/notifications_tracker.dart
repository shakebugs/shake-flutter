import 'package:shake_flutter/helpers/data_tracker.dart';
import 'package:shake_flutter/models/notification_event.dart';

typedef NotificationEvent NotificationEventFilter(
    NotificationEvent notificationEvent);

class NotificationsTracker extends DataTracker {
  NotificationEventFilter filter;

  NotificationEvent filterNotificationEvent(
      NotificationEvent notificationEvent) {
    if (filter != null) {
      NotificationEvent filteredEvent = filter(notificationEvent);
      return filteredEvent;
    }

    return notificationEvent;
  }
}
