import 'dart:async';

import 'package:flutter/services.dart';
import 'package:shake_flutter/enums/log_level.dart';
import 'package:shake_flutter/helpers/network_tracker.dart';
import 'package:shake_flutter/helpers/notifications_tracker.dart';
import 'package:shake_flutter/models/network_request.dart';
import 'package:shake_flutter/models/notification_event.dart';
import 'package:shake_flutter/models/shake_file.dart';
import 'package:shake_flutter/models/shake_report_configuration.dart';

/// Interface for using Shake SDK.
class Shake {
  static const MethodChannel _channel = const MethodChannel('shake');
  static NotificationsTracker _notificationsTracker = NotificationsTracker();
  static NetworkTracker _networkTracker = NetworkTracker();

  /// Initializes Shake.
  ///
  /// It should be called on application start.
  /// Shake won't work if method is not called.
  static start(String clientID, String clientSecret) async {
    _channel.setMethodCallHandler(_channelMethodHandler);
    await _channel.invokeMethod('start', {
      'clientId': clientID,
      'clientSecret': clientSecret,
    });
  }

  /// Shows Shake screen.
  ///
  /// Use this method to show Shake screen from the code.
  static show() async {
    await _channel.invokeMethod('show');
  }

  /// Enables or disables Shake.
  ///
  /// If false, Shake immediately stops tracking data
  /// and Shake screen invoking becomes disabled.
  static setEnabled(bool enabled) async {
    await _channel.invokeMethod('setEnabled', {
      'enabled': enabled,
    });
  }

  /// Sets if black-box is enabled.
  static setEnableBlackBox(bool enabled) async {
    await _channel.invokeMethod('setEnableBlackBox', {
      'enabled': enabled,
    });
  }

  /// Checks if black-box is enabled.
  static Future<bool?> isEnableBlackBox() async {
    return await _channel.invokeMethod('isEnableBlackBox');
  }

  /// Sets if activity history events are tracked.
  static setEnableActivityHistory(bool enabled) async {
    await _channel.invokeMethod('setEnableActivityHistory', {
      'enabled': enabled,
    });
  }

  /// Checks if activity history events are tracked.
  static Future<bool?> isEnableActivityHistory() async {
    return await _channel.invokeMethod('isEnableActivityHistory');
  }

  /// Sets if inspect screen button is visible on wrap up screen.
  static setEnableInspectScreen(bool enabled) async {
    await _channel.invokeMethod('setEnableInspectScreen', {
      'enabled': enabled,
    });
  }

  /// Checks if inspect screen button is visible on wrap up screen.
  static Future<bool?> isEnableInspectScreen() async {
    return await _channel.invokeMethod('isEnableInspectScreen');
  }

  /// Sets if floating report button is visible.
  static setShowFloatingReportButton(bool enabled) async {
    await _channel.invokeMethod('setShowFloatingReportButton', {
      'enabled': enabled,
    });
  }

  /// Checks if floating report button is visible.
  static Future<bool?> isShowFloatingReportButton() async {
    return await _channel.invokeMethod('isShowFloatingReportButton');
  }

  /// Sets if shake gesture invoking is enabled.
  static setInvokeShakeOnShakeDeviceEvent(bool enabled) async {
    await _channel.invokeMethod('setInvokeShakeOnShakeDeviceEvent', {
      'enabled': enabled,
    });
  }

  /// Checks if shake gesture invoking is enabled.
  static Future<bool?> isInvokeShakeOnShakeDeviceEvent() async {
    return await _channel.invokeMethod('isInvokeShakeOnShakeDeviceEvent');
  }

  /// Sets if screenshot invoking is enabled.
  static setInvokeShakeOnScreenshot(bool enabled) async {
    await _channel.invokeMethod('setInvokeShakeOnScreenshot', {
      'enabled': enabled,
    });
  }

  /// Checks if screenshot invoking is enabled.
  static Future<bool?> isInvokeShakeOnScreenshot() async {
    return await _channel.invokeMethod('isInvokeShakeOnScreenshot');
  }

  /// Sets files and quick facts which will be attached with bug report.
  static setShakeReportData(List<ShakeFile> shakeFiles) async {
    await _channel.invokeMethod('setShakeReportData', {
      'shakeFiles': _shakeFilesToMap(shakeFiles),
    });
  }

  /// Reports a bug without calling a Shake screen.
  ///
  /// [ShakeReportConfiguration] is required.
  static silentReport(
      {ShakeReportConfiguration? configuration,
      String? description,
      List<ShakeFile>? shakeFiles}) async {
    var c = configuration == null ? ShakeReportConfiguration() : configuration;
    await _channel.invokeMethod('silentReport', {
      'description': description,
      'shakeFiles': _shakeFilesToMap(shakeFiles),
      'configuration': c.toMap()
    });
  }

  /// Adds metadata to the bug report.
  static setMetadata(String key, String value) async {
    await _channel.invokeMethod('setMetadata', {
      'key': key,
      'value': value,
    });
  }

  /// Adds custom log to the Shake Report
  static log(LogLevel logLevel, String message) async {
    String logLevelString = logLevel.toString().split('.').last;
    await _channel.invokeMethod('log', {
      'level': logLevelString,
      'message': message,
    });
  }

  /// Checks if automatic video recording is enabled.
  static Future<bool?> isAutoVideoRecording() async {
    return await _channel.invokeMethod('isAutoVideoRecording');
  }

  /// Sets if automatic video recording is enabled.
  static setAutoVideoRecording(bool enabled) async {
    await _channel.invokeMethod('setAutoVideoRecording', {
      'enabled': enabled,
    });
  }

  /// Checks if email field is enabled.
  static Future<bool?> isEnableEmailField() async {
    return await _channel.invokeMethod('isEnableEmailField');
  }

  /// Sets if email field is enabled.
  static setEnableEmailField(bool enabled) async {
    await _channel.invokeMethod('setEnableEmailField', {
      'enabled': enabled,
    });
  }

  /// Gets default email field.
  static Future<String?> getEmailField() async {
    return await _channel.invokeMethod('getEmailField');
  }

  /// Sets default email field.
  static setEmailField(String email) async {
    await _channel.invokeMethod('setEmailField', {
      'email': email,
    });
  }

  /// Checks if feedback type picker is enabled.
  static Future<bool?> isEnableMultipleFeedbackTypes() async {
    return await _channel.invokeMethod('isEnableMultipleFeedbackTypes');
  }

  /// Sets if feedback type picker is enabled.
  static setEnableMultipleFeedbackTypes(bool enabled) async {
    await _channel.invokeMethod('setEnableMultipleFeedbackTypes', {
      'enabled': enabled,
    });
  }

  /// Checks if console logs are attached to the report.
  static Future<bool?> isConsoleLogsEnabled() async {
    return await _channel.invokeMethod('isConsoleLogsEnabled');
  }

  /// Sets if console logs are attached to the report
  static setConsoleLogsEnabled(bool enabled) async {
    await _channel.invokeMethod('setConsoleLogsEnabled', {
      'enabled': enabled,
    });
  }

  /// Checks if intro message is enabled.
  static Future<bool?> getShowIntroMessage() async {
    return await _channel.invokeMethod('getShowIntroMessage');
  }

  /// Sets if intro message is enabled.
  static setShowIntroMessage(bool enabled) async {
    await _channel.invokeMethod('setShowIntroMessage', {
      'enabled': enabled,
    });
  }

  /// Checks if automatic sensitive data redaction is enabled.
  static Future<bool?> isSensitiveDataRedactionEnabled() async {
    return await _channel.invokeMethod('isSensitiveDataRedactionEnabled');
  }

  /// Sets if automatic sensitive data redaction is enabled.
  static setSensitiveDataRedactionEnabled(bool enabled) async {
    await _channel.invokeMethod('setSensitiveDataRedactionEnabled', {
      'enabled': enabled,
    });
  }

  /// Inserts notification event to the activity history.
  ///
  /// Inserted notification event will be visible in the activity history.
  /// [NotificationEvent] should be filled properly.
  static insertNotificationEvent(NotificationEvent notificationEvent) async {
    NotificationEvent filteredEvent =
        _notificationsTracker.filterNotificationEvent(notificationEvent);
    await _channel.invokeMethod('insertNotificationEvent',
        {'notificationEvent': filteredEvent.toMap()});
  }

  /// Inserts network request to the activity history.
  ///
  /// Inserted network request will be visible in the activity history.
  /// [NetworkRequest] should be filled properly.
  static insertNetworkRequest(NetworkRequest networkRequest) async {
    NetworkRequest filteredRequest =
        _networkTracker.filterNetworkRequest(networkRequest);
    await _channel.invokeMethod(
        'insertNetworkRequest', {'networkRequest': filteredRequest.toMap()});
  }

  /// Sets filter for notification events.
  static setNotificationEventsFilter(NotificationEventFilter? filter) async {
    _notificationsTracker.filter = filter;
  }

  /// Sets filter for network requests.
  static setNetworkRequestsFilter(NetworkRequestFilter? filter) async {
    _networkTracker.filter = filter;
  }

  /// Shows notifications settings screen.
  ///
  /// This is used just for Android os.
  static showNotificationsSettings() async {
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

  /// Converts list of ShakeFile to list of maps
  static List<Map<String, dynamic>>? _shakeFilesToMap(
      List<ShakeFile>? shakeFiles) {
    var filesMap;
    if (shakeFiles != null) {
      filesMap = shakeFiles.map((shakeFile) => shakeFile.toMap()).toList();
    }
    return filesMap;
  }
}
