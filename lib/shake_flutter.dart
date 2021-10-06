import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shake_flutter/enums/log_level.dart';
import 'package:shake_flutter/helpers/network_tracker.dart';
import 'package:shake_flutter/helpers/notifications_tracker.dart';
import 'package:shake_flutter/models/feedback_type.dart';
import 'package:shake_flutter/models/network_request.dart';
import 'package:shake_flutter/models/notification_event.dart';
import 'package:shake_flutter/models/shake_file.dart';
import 'package:shake_flutter/models/shake_report_configuration.dart';
import 'package:shake_flutter/utils/mapper.dart';

/// Interface for using Shake SDK.
class Shake {
  static const MethodChannel _channel = const MethodChannel('shake');
  static NotificationsTracker _notificationsTracker = NotificationsTracker();
  static NetworkTracker _networkTracker = NetworkTracker();
  static Mapper _mapper = Mapper();

  /// Initializes Shake.
  ///
  /// It should be called on application start.
  /// Shake won't work if method is not called.
  static void start(String clientID, String clientSecret) async {
    _channel.setMethodCallHandler(_channelMethodHandler);
    await _channel.invokeMethod('start', {
      'clientId': clientID,
      'clientSecret': clientSecret,
    });
  }

  /// Shows Shake screen.
  ///
  /// Use this method to show Shake screen from the code.
  static void show() async {
    await _channel.invokeMethod('show');
  }

  /// Enables or disables Shake.
  ///
  /// If false, Shake immediately stops tracking data
  /// and Shake screen invoking becomes disabled.
  static void setEnabled(bool enabled) async {
    await _channel.invokeMethod('setEnabled', {
      'enabled': enabled,
    });
  }

  /// Sets if black-box is enabled.
  static void setEnableBlackBox(bool enabled) async {
    await _channel.invokeMethod('setEnableBlackBox', {
      'enabled': enabled,
    });
  }

  /// Checks if black-box is enabled.
  static Future<bool?> isEnableBlackBox() async {
    return await _channel.invokeMethod('isEnableBlackBox');
  }

  /// Sets if activity history events are tracked.
  static void setEnableActivityHistory(bool enabled) async {
    await _channel.invokeMethod('setEnableActivityHistory', {
      'enabled': enabled,
    });
  }

  /// Checks if activity history events are tracked.
  static Future<bool?> isEnableActivityHistory() async {
    return await _channel.invokeMethod('isEnableActivityHistory');
  }

  /// Sets if inspect screen button is visible on wrap up screen.
  static void setEnableInspectScreen(bool enabled) async {
    await _channel.invokeMethod('setEnableInspectScreen', {
      'enabled': enabled,
    });
  }

  /// Checks if inspect screen button is visible on wrap up screen.
  static Future<bool?> isEnableInspectScreen() async {
    return await _channel.invokeMethod('isEnableInspectScreen');
  }

  /// Sets if floating report button is visible.
  static void setShowFloatingReportButton(bool enabled) async {
    await _channel.invokeMethod('setShowFloatingReportButton', {
      'enabled': enabled,
    });
  }

  /// Checks if floating report button is visible.
  static Future<bool?> isShowFloatingReportButton() async {
    return await _channel.invokeMethod('isShowFloatingReportButton');
  }

  /// Sets if shake gesture invoking is enabled.
  static void setInvokeShakeOnShakeDeviceEvent(bool enabled) async {
    await _channel.invokeMethod('setInvokeShakeOnShakeDeviceEvent', {
      'enabled': enabled,
    });
  }

  /// Checks if shake gesture invoking is enabled.
  static Future<bool?> isInvokeShakeOnShakeDeviceEvent() async {
    return await _channel.invokeMethod('isInvokeShakeOnShakeDeviceEvent');
  }

  ///Checks what value shaking threshold is set on
  static Future<int?> getShakingThreshold() async {
    return await _channel.invokeMethod('getShakingThreshold');
  }

  ///Sets shaking threshold
  static setShakingThreshold(int shakingThreshold) async {
    await _channel.invokeMethod('setShakingThreshold', {
      'shakingThreshold': shakingThreshold,
    });
  }

  /// Sets if screenshot invoking is enabled.
  static void setInvokeShakeOnScreenshot(bool enabled) async {
    await _channel.invokeMethod('setInvokeShakeOnScreenshot', {
      'enabled': enabled,
    });
  }

  /// Checks if screenshot invoking is enabled.
  static Future<bool?> isInvokeShakeOnScreenshot() async {
    return await _channel.invokeMethod('isInvokeShakeOnScreenshot');
  }

  /// Checks if screenshot is included in report
  static Future<bool?> isScreenshotIncluded() async {
    return await _channel.invokeMethod('isScreenshotIncluded');
  }

  ///Sets screenshot included in report
  static void setScreenshotIncluded(bool enabled) async {
    await _channel.invokeMethod('setScreenshotIncluded', {
      'enabled': enabled,
    });
  }

  /// Sets files which will be attached with a ticket.
  static void setShakeReportData(List<ShakeFile> shakeFiles) async {
    await _channel.invokeMethod('setShakeReportData', {
      'shakeFiles': _mapper.shakeFilesToMap(shakeFiles),
    });
  }

  /// Sends a ticket without showing Shake screen.
  ///
  /// [ShakeReportConfiguration] is required.
  static void silentReport({
    ShakeReportConfiguration? configuration,
    String? description,
    List<ShakeFile>? shakeFiles,
  }) async {
    configuration ??= ShakeReportConfiguration();
    description ??= '';
    shakeFiles ??= [];

    await _channel.invokeMethod('silentReport', {
      'description': description,
      'shakeFiles': _mapper.shakeFilesToMap(shakeFiles),
      'configuration': configuration.toMap()
    });
  }

  /// Adds metadata to the new tickets.
  static void setMetadata(String key, String value) async {
    await _channel.invokeMethod('setMetadata', {
      'key': key,
      'value': value,
    });
  }

  /// Adds custom log into the activity history.
  static void log(LogLevel logLevel, String message) async {
    await _channel.invokeMethod('log', {
      'level': describeEnum(logLevel),
      'message': message,
    });
  }

  /// Checks if automatic video recording is enabled.
  static Future<bool?> isAutoVideoRecording() async {
    return await _channel.invokeMethod('isAutoVideoRecording');
  }

  /// Sets if automatic video recording is enabled.
  static void setAutoVideoRecording(bool enabled) async {
    await _channel.invokeMethod('setAutoVideoRecording', {
      'enabled': enabled,
    });
  }

  /// Checks if email field is enabled.
  static Future<bool?> isEnableEmailField() async {
    return await _channel.invokeMethod('isEnableEmailField');
  }

  /// Sets if email field is enabled.
  static void setEnableEmailField(bool enabled) async {
    await _channel.invokeMethod('setEnableEmailField', {
      'enabled': enabled,
    });
  }

  /// Gets default email field.
  static Future<String?> getEmailField() async {
    return await _channel.invokeMethod('getEmailField');
  }

  /// Sets default email field.
  static void setEmailField(String email) async {
    await _channel.invokeMethod('setEmailField', {
      'email': email,
    });
  }

  /// Checks if feedback type picker is visible on the new ticket screen.
  static Future<bool?> isFeedbackTypeEnabled() async {
    return await _channel.invokeMethod('isFeedbackTypeEnabled');
  }

  /// Sets if feedback type picker is visible on the new ticket screen.
  static void setFeedbackTypeEnabled(bool enabled) async {
    await _channel.invokeMethod('setFeedbackTypeEnabled', {
      'enabled': enabled,
    });
  }

  /// Gets feedback types shown on the new ticket screen.
  static Future<List<FeedbackType>> getFeedbackTypes() async {
    List<Map>? feedbackTypesMap =
        await _channel.invokeListMethod<Map>('getFeedbackTypes');
    return _mapper.mapToFeedbackTypes(feedbackTypesMap) ?? [];
  }

  /// Sets feedback types shown on the new ticket screen.
  static void setFeedbackTypes(List<FeedbackType> feedbackTypes) async {
    var feedbackTypesMap = _mapper.feedbackTypesToMap(feedbackTypes);
    await _channel.invokeMethod('setFeedbackTypes', {
      'feedbackTypes': feedbackTypesMap,
    });
  }

  /// Checks if console logs are attached to the tickets.
  static Future<bool?> isConsoleLogsEnabled() async {
    return await _channel.invokeMethod('isConsoleLogsEnabled');
  }

  /// Sets if console logs are attached to the tickets.
  static void setConsoleLogsEnabled(bool enabled) async {
    await _channel.invokeMethod('setConsoleLogsEnabled', {
      'enabled': enabled,
    });
  }

  /// Checks if intro message is shown on start.
  static Future<bool?> getShowIntroMessage() async {
    return await _channel.invokeMethod('getShowIntroMessage');
  }

  /// Sets if intro message is shown on start.
  static void setShowIntroMessage(bool enabled) async {
    await _channel.invokeMethod('setShowIntroMessage', {
      'enabled': enabled,
    });
  }

  /// Checks if automatic sensitive data redaction is enabled.
  static Future<bool?> isSensitiveDataRedactionEnabled() async {
    return await _channel.invokeMethod('isSensitiveDataRedactionEnabled');
  }

  /// Sets if automatic sensitive data redaction is enabled.
  static void setSensitiveDataRedactionEnabled(bool enabled) async {
    await _channel.invokeMethod('setSensitiveDataRedactionEnabled', {
      'enabled': enabled,
    });
  }

  /// Inserts notification event to the activity history.
  ///
  /// Inserted notification event will be visible in the activity history.
  /// [NotificationEvent] should be filled properly.
  static void insertNotificationEvent(
      NotificationEvent notificationEvent) async {
    NotificationEvent filteredEvent =
        _notificationsTracker.filterNotificationEvent(notificationEvent);
    await _channel.invokeMethod('insertNotificationEvent',
        {'notificationEvent': filteredEvent.toMap()});
  }

  /// Inserts network request to the activity history.
  ///
  /// Inserted network request will be visible in the activity history.
  /// [NetworkRequest] should be filled properly.
  static void insertNetworkRequest(NetworkRequest networkRequest) async {
    NetworkRequest filteredRequest =
        _networkTracker.filterNetworkRequest(networkRequest);
    await _channel.invokeMethod(
        'insertNetworkRequest', {'networkRequest': filteredRequest.toMap()});
  }

  /// Sets filter for notification events.
  static void setNotificationEventsFilter(
      NotificationEventFilter? filter) async {
    _notificationsTracker.filter = filter;
  }

  /// Sets filter for network requests.
  static void setNetworkRequestsFilter(NetworkRequestFilter? filter) async {
    _networkTracker.filter = filter;
  }

  /// Shows notifications settings screen.
  ///
  /// This is used just for Android os.
  static void showNotificationsSettings() async {
    await _channel.invokeMethod('showNotificationsSettings');
  }

  /// Handles method calls from native to Flutter
  static Future<void> _channelMethodHandler(MethodCall call) async {
    switch (call.method) {
      case 'onNotificationReceived':
        NotificationEvent notificationEvent =
            NotificationEvent.fromMap(call.arguments);
        insertNotificationEvent(notificationEvent);
        break;
    }
  }
}
