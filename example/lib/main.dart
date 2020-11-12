import 'package:flutter/material.dart';
import 'package:shake_example/ui/main/home.dart';
import 'package:shake_flutter/shake_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Shake.setShowFloatingReportButton(true);
  Shake.setInvokeShakeOnShakeDeviceEvent(true);
  Shake.setInvokeShakeOnScreenshot(true);
  Shake.start();

  runApp(Home());
}