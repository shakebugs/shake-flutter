import 'dart:async';

import 'package:flutter/services.dart';

class Shake {
  static const MethodChannel _channel = const MethodChannel('shake');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> start() async {
    await _channel.invokeMethod('start');
  }

  static Future<void> show() async {
    await _channel.invokeMethod('show');
  }

  static Future<void> setEnabled(bool enabled) async {
    await _channel.invokeMethod('setEnabled', {
      'enabled': enabled,
    });
  }

  static Future<void> setEnableBlackBox(bool enabled) async {
    await _channel.invokeMethod('setEnableBlackBox', {
      'enabled': enabled,
    });
  }

  static Future<bool> isEnableBlackBox() async {
    return await _channel.invokeMethod('show');
  }

  static Future<void> setEnableActivityHistory(bool enabled) async {
    await _channel.invokeMethod('setEnableActivityHistory', {
      'enabled': enabled,
    });
  }

  static Future<bool> isEnableActivityHistory() async {
    return await _channel.invokeMethod('show');
  }

  static Future<void> setEnableInspectScreen(bool enabled) async {
    await _channel.invokeMethod('setEnableInspectScreen', {
      'enabled': enabled,
    });
  }

  static Future<bool> isEnableInspectScreen() async {
    return await _channel.invokeMethod('show');
  }

  static Future<void> setShowFloatingReportButton(bool enabled) async {
    await _channel.invokeMethod('setShowFloatingReportButton', {
      'enabled': enabled,
    });
  }

  static Future<bool> isShowFloatingReportButton() async {
    return await _channel.invokeMethod('show');
  }

  static Future<void> setInvokeShakeOnShaking(bool enabled) async {
    await _channel.invokeMethod('setInvokeShakeOnShaking', {
      'enabled': enabled,
    });
  }

  static Future<bool> isInvokeShakeOnShaking() async {
    return await _channel.invokeMethod('show');
  }

  static Future<void> setInvokeShakeOnScreenshot(bool enabled) async {
    await _channel.invokeMethod('setInvokeShakeOnScreenshot', {
      'enabled': enabled,
    });
  }

  static Future<bool> isInvokeShakeOnScreenshot() async {
    return await _channel.invokeMethod('show');
  }

  static Future<void> setShakeReportData(bool enabled) async {
    await _channel.invokeMethod('setShakeReportData', {
      'enabled': enabled,
    });
  }

  static Future<void> silentReport() async {
    await _channel.invokeMethod('silentReport');
  }

  static Future<void> insertNetworkRequest() async {
    await _channel.invokeMethod('insertNetworkRequest');
  }
}
