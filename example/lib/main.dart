import 'package:flutter/material.dart';
import 'package:shake_example/ui/main/home.dart';
import 'package:shake_flutter/shake_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  const clientId = 'HtTFUmUziF5Qjk1XLraAJXtVB1cL62yHWWqsDnrG';
  const clientSecret =
      'IPRqEI2iSQhmUP6NGQcPNKCs7JQCJrpFUG0qDmLx4Yx2spd3caXnC3o';

  Shake.setInvokeShakeOnScreenshot(true);
  Shake.setInvokeShakeOnShakeDeviceEvent(true);
  Shake.setShowFloatingReportButton(true);
  Shake.setAutoVideoRecording(true);
  Shake.setShowIntroMessage(true);
  Shake.setSensitiveDataRedactionEnabled(true);
  Shake.setConsoleLogsEnabled(false);
  Shake.setHomeSubtitle("Flutter Shake example");
  Shake.start(clientId, clientSecret);

  runApp(Home());
}
