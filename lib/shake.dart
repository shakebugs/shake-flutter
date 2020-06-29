import 'dart:async';

import 'package:flutter/services.dart';
import 'package:shake/models/shake_file.dart';
import 'package:shake/models/shake_report_configuration.dart';

class Shake {
  static const MethodChannel _channel = const MethodChannel('shake');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

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
    return await _channel.invokeMethod('show');
  }

  static setEnableActivityHistory(bool enabled) async {
    await _channel.invokeMethod('setEnableActivityHistory', {
      'enabled': enabled,
    });
  }

  static Future<bool> isEnableActivityHistory() async {
    return await _channel.invokeMethod('show');
  }

  static setEnableInspectScreen(bool enabled) async {
    await _channel.invokeMethod('setEnableInspectScreen', {
      'enabled': enabled,
    });
  }

  static Future<bool> isEnableInspectScreen() async {
    return await _channel.invokeMethod('show');
  }

  static setShowFloatingReportButton(bool enabled) async {
    await _channel.invokeMethod('setShowFloatingReportButton', {
      'enabled': enabled,
    });
  }

  static Future<bool> isShowFloatingReportButton() async {
    return await _channel.invokeMethod('show');
  }

  static setInvokeShakeOnShaking(bool enabled) async {
    await _channel.invokeMethod('setInvokeShakeOnShaking', {
      'enabled': enabled,
    });
  }

  static Future<bool> isInvokeShakeOnShaking() async {
    return await _channel.invokeMethod('show');
  }

  static setInvokeShakeOnScreenshot(bool enabled) async {
    await _channel.invokeMethod('setInvokeShakeOnScreenshot', {
      'enabled': enabled,
    });
  }

  static Future<bool> isInvokeShakeOnScreenshot() async {
    return await _channel.invokeMethod('show');
  }

  static setShakeReportData(
    List<ShakeFile> shakeFiles,
    String quickFacts,
  ) async {
    final shakeFilesMap = shakeFiles.map((shakeFile) {
      return shakeFile.toMap();
    }).toList();

    await _channel.invokeMethod('setShakeReportData', {
      'shakeFiles': shakeFilesMap,
      'quickFacts': quickFacts,
    });
  }

  static silentReport(
    String description,
    List<ShakeFile> shakeFiles,
    String quickFacts,
    ShakeReportConfiguration configuration,
  ) async {
    final shakeFilesMap = shakeFiles.map((shakeFile) {
      return shakeFile.toMap();
    }).toList();

    await _channel.invokeMethod('silentReport', {
      'description': description,
      'shakeFiles': shakeFilesMap,
      'quickFacts': quickFacts,
      'configuration': configuration.toMap()
    });
  }

  static insertNetworkRequest() async {
    await _channel.invokeMethod('insertNetworkRequest');
  }
}
