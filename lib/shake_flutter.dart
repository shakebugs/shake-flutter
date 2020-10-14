import 'dart:async';

import 'package:flutter/services.dart';
import 'package:shake_flutter/models/network_request.dart';
import 'package:shake_flutter/models/shake_file.dart';
import 'package:shake_flutter/models/shake_report_configuration.dart';

/// Interface for using Shake SDK.
class Shake {
  static const MethodChannel _channel = const MethodChannel('shake');

  /// Initializes Shake.
  ///
  /// It should be called on application start.
  /// Shake won't work if method is not called.
  static start() async {
    await _channel.invokeMethod('start');
  }

  /// Shows Shake screen.
  ///
  /// Use this method to show Shake screen from code.
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
  static Future<bool> isEnableBlackBox() async {
    return await _channel.invokeMethod('isEnableBlackBox');
  }

  /// Sets if activity history events are tracked.
  static setEnableActivityHistory(bool enabled) async {
    await _channel.invokeMethod('setEnableActivityHistory', {
      'enabled': enabled,
    });
  }

  /// Checks if activity history events are tracked.
  static Future<bool> isEnableActivityHistory() async {
    return await _channel.invokeMethod('isEnableActivityHistory');
  }

  /// Sets if inspect screen button is visible on wrap up screen.
  static setEnableInspectScreen(bool enabled) async {
    await _channel.invokeMethod('setEnableInspectScreen', {
      'enabled': enabled,
    });
  }

  /// Checks if inspect screen button is visible on wrap up screen.
  static Future<bool> isEnableInspectScreen() async {
    return await _channel.invokeMethod('isEnableInspectScreen');
  }

  /// Sets if floating report button is visible.
  static setShowFloatingReportButton(bool enabled) async {
    await _channel.invokeMethod('setShowFloatingReportButton', {
      'enabled': enabled,
    });
  }

  /// Checks if floating report button is visible.
  static Future<bool> isShowFloatingReportButton() async {
    return await _channel.invokeMethod('isShowFloatingReportButton');
  }

  /// Sets if shake gesture invoking is enabled.
  static setInvokeShakeOnShakeDeviceEvent(bool enabled) async {
    await _channel.invokeMethod('setInvokeShakeOnShakeDeviceEvent', {
      'enabled': enabled,
    });
  }

  /// Checks if shake gesture invoking is enabled.
  static Future<bool> isInvokeShakeOnShakeDeviceEvent() async {
    return await _channel.invokeMethod('isInvokeShakeOnShakeDeviceEvent');
  }

  /// Sets if screenshot invoking is enabled.
  static setInvokeShakeOnScreenshot(bool enabled) async {
    await _channel.invokeMethod('setInvokeShakeOnScreenshot', {
      'enabled': enabled,
    });
  }

  /// Checks if screenshot invoking is enabled.
  static Future<bool> isInvokeShakeOnScreenshot() async {
    return await _channel.invokeMethod('isInvokeShakeOnScreenshot');
  }

  /// Sets files and quick facts which will be attached with bug report.
  static setShakeReportData(
    List<ShakeFile> shakeFiles,
    String quickFacts,
  ) async {
    final files = shakeFiles.map((shakeFile) => shakeFile.toMap()).toList();
    await _channel.invokeMethod('setShakeReportData', {
      'shakeFiles': files,
      'quickFacts': quickFacts,
    });
  }

  /// Reports a bug without calling a Shake screen.
  ///
  /// Bug will be reported to the dashboard with defined description.
  /// Pass [ShakeFile] or quick facts to attach additional bug details.
  /// Use [ShakeReportConfiguration] to define data attached to the report.
  static silentReport(
    String description,
    List<ShakeFile> shakeFiles,
    String quickFacts,
    ShakeReportConfiguration configuration,
  ) async {
    final files = shakeFiles.map((shakeFile) => shakeFile.toMap()).toList();
    await _channel.invokeMethod('silentReport', {
      'description': description,
      'shakeFiles': files,
      'quickFacts': quickFacts,
      'configuration': configuration.toMap()
    });
  }

  /// Inserts network request to the activity history.
  ///
  /// Inserted network request will be visible in the activity history.
  /// [NetworkRequest] should be filled properly.
  static insertNetworkRequest(NetworkRequest networkRequest) async {
    await _channel.invokeMethod(
        'insertNetworkRequest', {'networkRequest': networkRequest.toMap()});
  }
}
