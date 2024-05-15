import 'dart:io';

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
    print('Shake submitted!');
  });

  String apiKey = Platform.isIOS ?
    'zqED60FOrcVXsDBPyXBIUjLetFRg0thRYDQDgMje1qzZvE56VyeiQPC' :
    'JAHVv8hcIvifbThYFCuUC167u7u22DhlKKRzlzmo0mJfiAlbU3rFOYo';
  await Shake.start(apiKey);

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
