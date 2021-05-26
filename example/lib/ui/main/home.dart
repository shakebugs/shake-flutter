import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shake_example/constants/colors.dart';
import 'package:shake_example/helpers/dart_tester.dart';
import 'package:shake_example/helpers/network_tester.dart';
import 'package:shake_example/ui/base/button.dart';
import 'package:shake_example/ui/base/header.dart';
import 'package:shake_example/ui/base/link.dart';
import 'package:shake_example/ui/base/logo.dart';
import 'package:shake_example/ui/base/toggle.dart';
import 'package:shake_example/ui/base/version.dart';
import 'package:shake_example/utils/files.dart';
import 'package:shake_example/utils/messages.dart';
import 'package:shake_flutter/enums/log_level.dart';
import 'package:shake_flutter/models/network_request.dart';
import 'package:shake_flutter/models/notification_event.dart';
import 'package:shake_flutter/models/shake_file.dart';
import 'package:shake_flutter/models/shake_report_configuration.dart';
import 'package:shake_flutter/shake_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NetworkTester networkTester = DartTester();

  bool? shakeInvokingEnabled = false;
  bool? buttonInvokingEnabled = false;
  bool? screenshotInvokingEnabled = false;
  bool? shakeEnabled = false;
  bool? blackboxEnabled = false;
  bool? inspectScreenEnabled = false;
  bool? activityHistoryEnabled = false;
  bool? consoleLogsEnabled = false;
  bool? emailFieldEnabled = false;
  bool? feedbackTypesEnabled = false;
  bool? screenRecordingEnabled = false;
  bool? sensitiveDataEnabled = false;

  File? file1;
  File? file2;

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  _initialize() async {
    final shakeInvokingEnabled = await Shake.isInvokeShakeOnShakeDeviceEvent();
    final buttonInvokingEnabled = await Shake.isShowFloatingReportButton();
    final screenshotInvokingEnabled = await Shake.isInvokeShakeOnScreenshot();
    final shakeEnabled = true; // Not provided by native SDK
    final blackboxEnabled = await Shake.isEnableBlackBox();
    final inspectScreenEnabled = await Shake.isEnableInspectScreen();
    final activityHistoryEnabled = await Shake.isEnableActivityHistory();
    final consoleLogsEnabled = await Shake.isConsoleLogsEnabled();
    final emailFieldEnabled = await Shake.isEnableEmailField();
    final feedbackTypesEnabled = await Shake.isEnableMultipleFeedbackTypes();
    final screenRecordingEnabled = await Shake.isAutoVideoRecording();
    final sensitiveDataEnabled = await Shake.isSensitiveDataRedactionEnabled();

    setState(() {
      this.shakeInvokingEnabled = shakeInvokingEnabled;
      this.buttonInvokingEnabled = buttonInvokingEnabled;
      this.screenshotInvokingEnabled = screenshotInvokingEnabled;
      this.shakeEnabled = shakeEnabled;
      this.blackboxEnabled = blackboxEnabled;
      this.inspectScreenEnabled = inspectScreenEnabled;
      this.activityHistoryEnabled = activityHistoryEnabled;
      this.consoleLogsEnabled = consoleLogsEnabled;
      this.emailFieldEnabled = emailFieldEnabled;
      this.feedbackTypesEnabled = feedbackTypesEnabled;
      this.screenRecordingEnabled = screenRecordingEnabled;
      this.sensitiveDataEnabled = sensitiveDataEnabled;
    });

    file1 = await Files.createDummyFile('file1.txt');
    file2 = await Files.createDummyFile('file2.txt');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'HKGrotesk',
        primarySwatch: ThemeColors.white,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Logo(),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header('Actions'),
                        Button(
                          'Show',
                          _onShowPress,
                        ),
                        Button(
                          'Attach data',
                          _onAttachDataPress,
                        ),
                        Button(
                          'Silent report',
                          _onSilentReportPress,
                        ),
                        Button(
                          'Custom log',
                          _addCustomLog,
                        ),
                        Button(
                          'Add metadata',
                          _addMetadata,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header('Invoking'),
                        Toggle(
                          'Shaking',
                          shakeInvokingEnabled!,
                          _onShakeInvokingToggle,
                        ),
                        Toggle(
                          'Button',
                          buttonInvokingEnabled!,
                          _onButtonInvokingToggle,
                        ),
                        Toggle(
                          'Screenshot',
                          screenshotInvokingEnabled!,
                          _onScreenshotInvokingToggle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header('Options'),
                        Toggle(
                          'Enabled',
                          shakeEnabled!,
                          _onEnableShakeToggle,
                        ),
                        Toggle(
                          'Blackbox',
                          blackboxEnabled!,
                          _onEnableBlackboxToggle,
                        ),
                        Toggle(
                          'Inspect screen',
                          inspectScreenEnabled!,
                          _onEnableInspectScreenToggle,
                        ),
                        Toggle(
                          'Activity history',
                          activityHistoryEnabled!,
                          _onEnableActivityHistoryToggle,
                        ),
                        Toggle(
                          'Console logs',
                          consoleLogsEnabled!,
                          _onConsoleLogsEnabledToggle,
                        ),
                        Toggle(
                          'Email field',
                          emailFieldEnabled!,
                          _onEmailFieldEnabledToggle,
                        ),
                        Toggle(
                          'Feedback types',
                          feedbackTypesEnabled!,
                          _onFeedbackTypesEnabledToggle,
                        ),
                        Toggle(
                          'Screen recording',
                          screenRecordingEnabled!,
                          _onScreenRecordingEnabledToggle,
                        ),
                        Toggle(
                          'Sensitive data redaction',
                          sensitiveDataEnabled!,
                          _onSensitiveDataEnabledToggle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header('Notifications'),
                        Button('Show notification settings',
                            _showNotificationSettings),
                        Button(
                            'Post notification event', _postNotificationEvent),
                        Button(
                          'Insert notification event',
                          _insertNotificationEvent,
                        ),
                        Button(
                          'Set notification events filter',
                          _setNotificationEventsFilter,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header('Tools'),
                        Button(
                          'Send GET request',
                          _onSendGetRequest,
                        ),
                        Button(
                          'Send POST request',
                          _onSendPostRequest,
                        ),
                        Button(
                          'Send GET file request',
                          _onGetFileRequest,
                        ),
                        Button(
                          'Send POST file request',
                          _onSendMultipartFileRequest,
                        ),
                        Button(
                          'Send 404 request',
                          _onSend404Request,
                        ),
                        Button(
                          'Send timeout request',
                          _onSendTimeoutRequest,
                        ),
                        Button(
                          'Insert network request',
                          _insertNetworkRequest,
                        ),
                        Button(
                          'Set network requests filter',
                          _setNetworkRequestsFilter,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Link(
                          'Dashboard',
                          'https://app.staging5h4k3.com/',
                        ),
                        Link(
                          'Documentation',
                          'https://www.staging5h4k3.com/docs',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Version(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  _onShowPress() {
    Shake.show();
  }

  _onEnableShakeToggle(enabled) {
    setState(() {
      shakeEnabled = enabled;
    });
    Shake.setEnabled(enabled);
  }

  _onShakeInvokingToggle(enabled) {
    setState(() {
      shakeInvokingEnabled = enabled;
    });
    Shake.setInvokeShakeOnShakeDeviceEvent(enabled);
  }

  _onButtonInvokingToggle(enabled) {
    setState(() {
      buttonInvokingEnabled = enabled;
    });
    Shake.setShowFloatingReportButton(enabled);
  }

  _onScreenshotInvokingToggle(enabled) {
    setState(() {
      screenshotInvokingEnabled = enabled;
    });
    Shake.setInvokeShakeOnScreenshot(enabled);
  }

  _onEnableBlackboxToggle(enabled) {
    setState(() {
      blackboxEnabled = enabled;
    });
    Shake.setEnableBlackBox(enabled);
  }

  _onEnableActivityHistoryToggle(enabled) {
    setState(() {
      activityHistoryEnabled = enabled;
    });
    Shake.setEnableActivityHistory(enabled);
  }

  _onEnableInspectScreenToggle(enabled) {
    setState(() {
      inspectScreenEnabled = enabled;
    });
    Shake.setEnableInspectScreen(enabled);
  }

  _onConsoleLogsEnabledToggle(enabled) {
    setState(() {
      consoleLogsEnabled = enabled;
    });
    Shake.setConsoleLogsEnabled(enabled);
  }

  _onEmailFieldEnabledToggle(enabled) {
    setState(() {
      emailFieldEnabled = enabled;
    });
    Shake.setEnableEmailField(enabled);
  }

  _onFeedbackTypesEnabledToggle(enabled) {
    setState(() {
      feedbackTypesEnabled = enabled;
    });
    Shake.setEnableMultipleFeedbackTypes(feedbackTypesEnabled!);
  }

  _onScreenRecordingEnabledToggle(enabled) {
    setState(() {
      screenRecordingEnabled = enabled;
    });
    Shake.setAutoVideoRecording(screenRecordingEnabled!);
  }

  _onSensitiveDataEnabledToggle(enabled) {
    setState(() {
      sensitiveDataEnabled = enabled;
    });
    Shake.setSensitiveDataRedactionEnabled(sensitiveDataEnabled!);
  }

  _onAttachDataPress() {
    List<ShakeFile> shakeFiles = [];
    shakeFiles.add(ShakeFile.create(file1!.path));
    shakeFiles.add(ShakeFile.create(file2!.path, 'customName'));

    Shake.setShakeReportData(shakeFiles);
  }

  _onSilentReportPress() {
    List<ShakeFile> shakeFiles = [];
    shakeFiles.add(ShakeFile.create(file1!.path));
    shakeFiles.add(ShakeFile.create(file2!.path, 'customName'));

    ShakeReportConfiguration configuration = ShakeReportConfiguration();
    configuration.activityHistoryData = true;
    configuration.blackBoxData = true;
    configuration.screenshot = true;
    configuration.showReportSentMessage = true;

    Shake.silentReport(
      configuration: configuration,
      description: 'Description',
      shakeFiles: shakeFiles,
    );
  }

  _addCustomLog() {
    Shake.log(LogLevel.info, 'Custom log.');
  }

  _addMetadata() {
    Shake.setMetadata('Shake', 'This is a Shake metadata.');
  }

  _showNotificationSettings() {
    Shake.showNotificationsSettings();
  }

  _postNotificationEvent() async {
    FlutterLocalNotificationsPlugin notificationsPlugin =
        FlutterLocalNotificationsPlugin();

    InitializationSettings initializationSettings = InitializationSettings(
        android: AndroidInitializationSettings('@drawable/ic_bug_report'),
        iOS: IOSInitializationSettings());

    await notificationsPlugin.initialize(initializationSettings);

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
            'shake-flutter', 'Shake Flutter', 'Shake Flutter channel');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidDetails);
    await notificationsPlugin.show(
        0,
        'This notification was generated by the app!',
        'Notification message.',
        platformChannelSpecifics);
  }

  _insertNotificationEvent() {
    NotificationEvent notificationEvent = NotificationEvent()
      ..id = '0'
      ..title = 'Title'
      ..description = 'Description';
    Shake.insertNotificationEvent(notificationEvent);
  }

  _insertNetworkRequest() {
    NetworkRequest networkRequest = NetworkRequest()
      ..method = 'POST'
      ..status = '200'
      ..url = 'https://www.shakebugs.com'
      ..requestBody = 'Request body'
      ..responseBody = 'Response body'
      ..requestHeaders = {'testHeader1': 'value'}
      ..responseHeaders = {'testHeader2': 'value'}
      ..duration = 100
      ..date = new DateTime.now();
    Shake.insertNetworkRequest(networkRequest);
  }

  _setNotificationEventsFilter() {
    Shake.setNotificationEventsFilter((notificationEvent) {
      notificationEvent.title = "data_redacted";
      notificationEvent.description = "data_redacted";
      return notificationEvent;
    });
  }

  _setNetworkRequestsFilter() {
    Shake.setNetworkRequestsFilter((networkRequest) {
      networkRequest.requestBody = "data_redacted";
      networkRequest.responseBody = "data_redacted";
      return networkRequest;
    });
  }

  _onSendGetRequest() async {
    try {
      await networkTester.sendGetRequest();

      Messages.show("Request succeeded.");
    } catch (e) {
      Messages.show(e.toString());
    }
  }

  _onSendPostRequest() async {
    try {
      await networkTester.sendPostRequest();

      Messages.show("Request succeeded.");
    } catch (e) {
      Messages.show(e.toString());
    }
  }

  _onGetFileRequest() async {
    try {
      await networkTester.sendGetFileRequest();

      Messages.show("Request succeeded.");
    } catch (e) {
      Messages.show(e.toString());
    }
  }

  _onSendMultipartFileRequest() async {
    try {
      await networkTester.sendMultipartFileRequest();

      Messages.show("Request succeeded.");
    } catch (e) {
      Messages.show(e.toString());
    }
  }

  _onSend404Request() async {
    try {
      await networkTester.send404Request();

      Messages.show("Request succeeded.");
    } catch (e) {
      Messages.show(e.toString());
    }
  }

  _onSendTimeoutRequest() async {
    try {
      await networkTester.sendTimeoutRequest();

      Messages.show("Request succeeded.");
    } catch (e) {
      Messages.show(e.toString());
    }
  }
}
