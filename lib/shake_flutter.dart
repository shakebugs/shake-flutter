import 'dart:async';
import 'package:flutter/services.dart';
import 'package:shake_flutter/models/shake_file.dart';
import 'package:shake_flutter/models/shake_report_configuration.dart';

class Shake {
  static const MethodChannel _channel = const MethodChannel('shake');

  static start() async {
    await _channel.invokeMethod('start');
  }

  static show() async {
    await _channel.invokeMethod('show');
  }

  static setEnabled(bool enabled) async {
    await _channel.invokeMethod('setEnabled', {
      'enabled': enabled,
    });
  }

  static setEnableBlackBox(bool enabled) async {
    await _channel.invokeMethod('setEnableBlackBox', {
      'enabled': enabled,
    });
  }

  static Future<bool> isEnableBlackBox() async {
    return await _channel.invokeMethod('isEnableBlackBox');
  }

  static setEnableActivityHistory(bool enabled) async {
    await _channel.invokeMethod('setEnableActivityHistory', {
      'enabled': enabled,
    });
  }

  static Future<bool> isEnableActivityHistory() async {
    return await _channel.invokeMethod('isEnableActivityHistory');
  }

  static setEnableInspectScreen(bool enabled) async {
    await _channel.invokeMethod('setEnableInspectScreen', {
      'enabled': enabled,
    });
  }

  static Future<bool> isEnableInspectScreen() async {
    return await _channel.invokeMethod('isEnableInspectScreen');
  }

  static setShowFloatingReportButton(bool enabled) async {
    await _channel.invokeMethod('setShowFloatingReportButton', {
      'enabled': enabled,
    });
  }

  static Future<bool> isShowFloatingReportButton() async {
    return await _channel.invokeMethod('isShowFloatingReportButton');
  }

  static setInvokeShakeOnShaking(bool enabled) async {
    await _channel.invokeMethod('setInvokeShakeOnShaking', {
      'enabled': enabled,
    });
  }

  static Future<bool> isInvokeShakeOnShaking() async {
    return await _channel.invokeMethod('isInvokeShakeOnShaking');
  }

  static setInvokeShakeOnScreenshot(bool enabled) async {
    await _channel.invokeMethod('setInvokeShakeOnScreenshot', {
      'enabled': enabled,
    });
  }

  static Future<bool> isInvokeShakeOnScreenshot() async {
    return await _channel.invokeMethod('isInvokeShakeOnScreenshot');
  }

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

  static insertNetworkRequest() async {
    await _channel.invokeMethod('insertNetworkRequest');
  }
}
