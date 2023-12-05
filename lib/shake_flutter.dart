import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shake_flutter/enums/log_level.dart';
import 'package:shake_flutter/enums/shake_screen.dart';
import 'package:shake_flutter/helpers/configuration.dart';
import 'package:shake_flutter/helpers/network_tracker.dart';
import 'package:shake_flutter/helpers/notifications_tracker.dart';
import 'package:shake_flutter/models/chat_notification.dart';
import 'package:shake_flutter/models/network_request.dart';
import 'package:shake_flutter/models/notification_event.dart';
import 'package:shake_flutter/models/shake_base_action.dart';
import 'package:shake_flutter/models/shake_file.dart';
import 'package:shake_flutter/models/shake_form.dart';
import 'package:shake_flutter/models/shake_report_configuration.dart';
import 'package:shake_flutter/models/shake_theme.dart';
import 'package:shake_flutter/utils/mapper.dart';

/// Interface for using Shake SDK.
class Shake {
  static const MethodChannel _channel = const MethodChannel('shake');
  static Configuration _configuration = Configuration();
  static NotificationsTracker _notificationsTracker = NotificationsTracker();
  static NetworkTracker _networkTracker = NetworkTracker();
  static Mapper _mapper = Mapper();

  /// Initializes Shake.
  ///
  /// It should be called on application start.
  /// Shake won't work if method is not called.
  static Future<void> start(String clientID, String clientSecret) async {
    _channel.setMethodCallHandler(_channelMethodHandler);
    await _channel.invokeMethod('start', {
      'clientId': clientID,
      'clientSecret': clientSecret,
    });
  }

  /// Gets shake form for the new ticket screen.
  static Future<ShakeForm?> getShakeForm() async {
    Map? shakeFormMap = await _channel.invokeMethod('getShakeForm');
    if (shakeFormMap == null) return null;
    return ShakeForm.fromMap(shakeFormMap);
  }

  /// Sets shake form for the new ticket screen.
  static Future<void> setShakeForm(ShakeForm? shakeForm) async {
    var shakeFormMap = shakeForm?.toMap();
    await _channel.invokeMethod('setShakeForm', {
      'shakeForm': shakeFormMap,
    });
  }

  /// Sets shake theme for the Shake UI.
  static Future<void> setShakeTheme(ShakeTheme shakeTheme) async {
    var shakeThemeMap = shakeTheme.toMap();
    await _channel.invokeMethod('setShakeTheme', {
      'shakeTheme': shakeThemeMap,
    });
  }

  /// Sets shake home screen subtitle.
  static Future<void> setHomeSubtitle(String subtitle) async {
    await _channel.invokeMethod('setHomeSubtitle', {
      'subtitle': subtitle,
    });
  }

  /// Sets shake home screen subtitle.
  static Future<void> setHomeActions(List<ShakeBaseAction> homeActions) async {
    _configuration.homeActions = homeActions;
    await _channel.invokeMethod('setHomeActions', {
      'homeActions': homeActions.map((action) => action.toMap()).toList(),
    });
  }

  /// Shows Shake screen.
  ///
  /// [ShakeScreen.home], [ShakeScreen.newTicket] or [ShakeScreen.chat].
  /// The default one is [ShakeScreen.newTicket]
  static Future<void> show([shakeScreen = ShakeScreen.newTicket]) async {
    await _channel.invokeMethod('show', {
      'shakeScreen': describeEnum(shakeScreen),
    });
  }

  /// Sets if user feedback is enabled.
  static Future<void> setUserFeedbackEnabled(bool enabled) async {
    await _channel.invokeMethod('setUserFeedbackEnabled', {
      'enabled': enabled,
    });
  }

  /// Checks if user feedback is enabled.
  static Future<bool?> isUserFeedbackEnabled() async {
    return await _channel.invokeMethod('isUserFeedbackEnabled');
  }

  /// Sets if black-box is enabled.
  static Future<void> setEnableBlackBox(bool enabled) async {
    await _channel.invokeMethod('setEnableBlackBox', {
      'enabled': enabled,
    });
  }

  /// Checks if black-box is enabled.
  static Future<bool?> isEnableBlackBox() async {
    return await _channel.invokeMethod('isEnableBlackBox');
  }

  /// Sets if activity history events are tracked.
  static Future<void> setEnableActivityHistory(bool enabled) async {
    await _channel.invokeMethod('setEnableActivityHistory', {
      'enabled': enabled,
    });
  }

  /// Checks if activity history events are tracked.
  static Future<bool?> isEnableActivityHistory() async {
    return await _channel.invokeMethod('isEnableActivityHistory');
  }

  /// Sets if floating report button is visible.
  static Future<void> setShowFloatingReportButton(bool enabled) async {
    await _channel.invokeMethod('setShowFloatingReportButton', {
      'enabled': enabled,
    });
  }

  /// Checks if floating report button is visible.
  static Future<bool?> isShowFloatingReportButton() async {
    return await _channel.invokeMethod('isShowFloatingReportButton');
  }

  /// Sets if shake gesture invoking is enabled.
  static Future<void> setInvokeShakeOnShakeDeviceEvent(bool enabled) async {
    await _channel.invokeMethod('setInvokeShakeOnShakeDeviceEvent', {
      'enabled': enabled,
    });
  }

  /// Checks if shake gesture invoking is enabled.
  static Future<bool?> isInvokeShakeOnShakeDeviceEvent() async {
    return await _channel.invokeMethod('isInvokeShakeOnShakeDeviceEvent');
  }

  /// Get screen top open when Shake is manually invoked.
  ///
  /// Returns [ShakeScreen.home] or [ShakeScreen.newTicket].
  static Future<ShakeScreen> getDefaultScreen() async {
    var defaultScreenStr = await _channel.invokeMethod('getDefaultScreen');
    return _mapper.mapToShakeScreen(defaultScreenStr);
  }

  /// Sets screen to open when Shake is manually invoked.
  ///
  /// [ShakeScreen.home] or [ShakeScreen.newTicket].
  static Future<void> setDefaultScreen(ShakeScreen shakeScreen) async {
    await _channel.invokeMethod('setDefaultScreen', {
      'shakeScreen': describeEnum(shakeScreen),
    });
  }

  ///Checks what value shaking threshold is set on
  static Future<int?> getShakingThreshold() async {
    return await _channel.invokeMethod('getShakingThreshold');
  }

  ///Sets shaking threshold
  static Future<void> setShakingThreshold(int shakingThreshold) async {
    await _channel.invokeMethod('setShakingThreshold', {
      'shakingThreshold': shakingThreshold,
    });
  }

  /// Sets if screenshot invoking is enabled.
  static Future<void> setInvokeShakeOnScreenshot(bool enabled) async {
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
  static Future<void> setScreenshotIncluded(bool enabled) async {
    await _channel.invokeMethod('setScreenshotIncluded', {
      'enabled': enabled,
    });
  }

  /// Sets files which will be attached with a ticket.
  static Future<void> setShakeReportData(List<ShakeFile> shakeFiles) async {
    await _channel.invokeMethod('setShakeReportData', {
      'shakeFiles': shakeFiles.map((shakeFile) => shakeFile.toMap()).toList(),
    });
  }

  /// Sends a ticket without showing Shake screen.
  ///
  /// [ShakeReportConfiguration] is required.
  static Future<void> silentReport({
    ShakeReportConfiguration? configuration,
    String? description,
    List<ShakeFile>? shakeFiles,
  }) async {
    configuration ??= ShakeReportConfiguration();
    description ??= '';
    shakeFiles ??= [];

    await _channel.invokeMethod('silentReport', {
      'description': description,
      'shakeFiles': shakeFiles.map((shakeFile) => shakeFile.toMap()).toList(),
      'configuration': configuration.toMap()
    });
  }

  /// Adds metadata to the new tickets.
  static Future<void> setMetadata(String key, String value) async {
    await _channel.invokeMethod('setMetadata', {
      'key': key,
      'value': value,
    });
  }

  /// Clears existing metadata.
  static Future<void> clearMetadata() async {
    await _channel.invokeMethod('clearMetadata');
  }

  /// Adds custom log into the activity history.
  static Future<void> log(LogLevel logLevel, String message) async {
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
  static Future<void> setAutoVideoRecording(bool enabled) async {
    await _channel.invokeMethod('setAutoVideoRecording', {
      'enabled': enabled,
    });
  }

  /// Checks if console logs are attached to the tickets.
  static Future<bool?> isConsoleLogsEnabled() async {
    return await _channel.invokeMethod('isConsoleLogsEnabled');
  }

  /// Sets if console logs are attached to the tickets.
  static Future<void> setConsoleLogsEnabled(bool enabled) async {
    await _channel.invokeMethod('setConsoleLogsEnabled', {
      'enabled': enabled,
    });
  }

  /// Checks if intro message is shown on start.
  static Future<bool?> getShowIntroMessage() async {
    return await _channel.invokeMethod('getShowIntroMessage');
  }

  /// Sets if intro message is shown on start.
  static Future<void> setShowIntroMessage(bool enabled) async {
    await _channel.invokeMethod('setShowIntroMessage', {
      'enabled': enabled,
    });
  }

  /// Checks if automatic sensitive data redaction is enabled.
  static Future<bool?> isSensitiveDataRedactionEnabled() async {
    return await _channel.invokeMethod('isSensitiveDataRedactionEnabled');
  }

  /// Sets if automatic sensitive data redaction is enabled.
  static Future<void> setSensitiveDataRedactionEnabled(bool enabled) async {
    await _channel.invokeMethod('setSensitiveDataRedactionEnabled', {
      'enabled': enabled,
    });
  }

  /// Registers new Shake user.
  static Future<void> registerUser(String userId) async {
    await _channel.invokeMethod('registerUser', {
      'userId': userId,
    });
  }

  /// Updates existing Shake user id.
  static Future<void> updateUserId(String userId) async {
    await _channel.invokeMethod('updateUserId', {
      'userId': userId,
    });
  }

  /// Updates existing Shake user metadata.
  static Future<void> updateUserMetadata(Map<String, String?> metadata) async {
    await _channel.invokeMethod('updateUserMetadata', {
      'metadata': metadata,
    });
  }

  /// Unregister current Shake user.
  static Future<void> unregisterUser() async {
    await _channel.invokeMethod('unregisterUser');
  }

  /// Inserts notification event to the activity history.
  ///
  /// Inserted notification event will be visible in the activity history.
  /// [NotificationEvent] should be filled properly.
  static Future<void> insertNotificationEvent(
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
  static Future<void> insertNetworkRequest(
      NetworkRequest networkRequest) async {
    NetworkRequest filteredRequest =
        _networkTracker.filterNetworkRequest(networkRequest);
    await _channel.invokeMethod(
        'insertNetworkRequest', {'networkRequest': filteredRequest.toMap()});
  }

  /// Sets filter for notification events.
  ///
  /// Set null if you want to remove filter.
  static Future<void> setNotificationEventsFilter(
      NotificationEventFilter? filter) async {
    _notificationsTracker.filter = filter;
  }

  /// Sets filter for network requests.
  ///
  /// Set null if you want to remove filter.
  static Future<void> setNetworkRequestsFilter(
      NetworkRequestFilter? filter) async {
    _networkTracker.filter = filter;
  }

  /// Shows notifications settings screen.
  ///
  /// This is used just for Android os.
  static Future<void> showNotificationsSettings() async {
    await _channel.invokeMethod('showNotificationsSettings');
  }

  /// Sets unread chat messages number listener.
  ///
  /// Set null if you want to remove listener.
  static Future<void> setUnreadMessagesListener(
      UnreadMessagesListener? listener) async {
    _configuration.unreadMessagesListener = listener;
    await _channel.invokeMethod('startUnreadMessagesEmitter');
  }

  /// Sets token used to send push notifications (Only Android).
  ///
  /// Set null if you want to remove token.
  static Future<void> setPushNotificationsToken(String? token) async {
    if (Platform.isAndroid) {
      await _channel
          .invokeMethod('setPushNotificationsToken', {'token': token});
    }
  }

  /// Shows Firebase chat notification (Only Android).
  static Future<void> showChatNotification(Map<String, dynamic> data) async {
    if (Platform.isAndroid) {
      ChatNotification chatNotification = ChatNotification(data['ticket_id'],
          data['user_id'], data['ticket_title'], data['message']);
      await _channel.invokeMethod('showChatNotification',
          {'chatNotification': chatNotification.toMap()});
    }
  }

  /// Sets Shake open event listener.
  ///
  /// Set null if you want to remove listener.
  static void setShakeOpenListener(Function? listener) {
    _configuration.onShakeOpen = listener;
  }

  /// Sets Shake dismiss event listener.
  ///
  /// Set null if you want to remove listener.
  static void setShakeDismissListener(Function? listener) {
    _configuration.onShakeDismiss = listener;
  }

  /// Sets Shake submit event listener.
  ///
  /// Set null if you want to remove listener.
  static void setShakeSubmitListener(
      Function(String, Map<String, String>)? listener) {
    _configuration.onShakeSubmit = listener;
  }

  /// Sets ticket tags.
  static Future<void> setTags(List<String> tags) async {
    await _channel.invokeMethod('setTags', {
      'tags': tags,
    });
  }

  /// Handles method calls from native to Flutter
  static Future<void> _channelMethodHandler(MethodCall call) async {
    switch (call.method) {
      case 'onNotificationReceived':
        NotificationEvent notificationEvent =
            NotificationEvent.fromMap(call.arguments);
        insertNotificationEvent(notificationEvent);
        break;
      case 'onUnreadMessagesReceived':
        int count = call.arguments;
        _configuration.unreadMessagesListener?.call(count);
        break;
      case 'onHomeActionTap':
        _configuration.homeActions
            ?.firstWhere((element) => element.title == call.arguments)
            .handler
            ?.call();
        break;
      case 'onShakeOpen':
        _configuration.onShakeOpen?.call();
        break;
      case 'onShakeDismiss':
        _configuration.onShakeDismiss?.call();
        break;
      case 'onShakeSubmit':
        String type = call.arguments['type'];
        Map<String, String> fields =
            Map.castFrom<dynamic, dynamic, String, String>(
                call.arguments['fields']);
        _configuration.onShakeSubmit?.call(type, fields);
        break;
    }
  }
}
