import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shake_example/dark_mode_observer.dart';
import 'package:shake_example/ui/main/home.dart';
import 'package:shake_flutter/shake_flutter.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Message data: ${message.data}');

  await Firebase.initializeApp();
  await startShake();

  Shake.showChatNotification(message.data);
}

Future<void> startShake() async {
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

  Shake.setShakeOpenListener(() {
    print('Shake opened!');
  });
  Shake.setShakeDismissListener(() {
    print('Shake dismissed!');
  });
  Shake.setShakeSubmitListener((String type, Map<String, String> fields) {
    print(type);
    print(fields);
    print('Shake submitted!');
  });

  await Shake.start(clientId, clientSecret);

  Shake.registerUser("test_user");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  startShake();

  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Message data: ${message.data}');
    Shake.showChatNotification(message.data);
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  String? fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
  Shake.setPushNotificationsToken(fcmToken);

  runApp(DarkModeObserver(child: Home()));
}
