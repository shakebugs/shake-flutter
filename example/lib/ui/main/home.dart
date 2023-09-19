import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shake_example/assets/sample_image.dart';
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
import 'package:shake_flutter/enums/shake_screen.dart';
import 'package:shake_flutter/models/network_request.dart';
import 'package:shake_flutter/models/notification_event.dart';
import 'package:shake_flutter/models/shake_attachments.dart';
import 'package:shake_flutter/models/shake_base_action.dart';
import 'package:shake_flutter/models/shake_chat_action.dart';
import 'package:shake_flutter/models/shake_email.dart';
import 'package:shake_flutter/models/shake_file.dart';
import 'package:shake_flutter/models/shake_form.dart';
import 'package:shake_flutter/models/shake_home_action.dart';
import 'package:shake_flutter/models/shake_inspect_button.dart';
import 'package:shake_flutter/models/shake_picker.dart';
import 'package:shake_flutter/models/shake_picker_item.dart';
import 'package:shake_flutter/models/shake_report_configuration.dart';
import 'package:shake_flutter/models/shake_submit_action.dart';
import 'package:shake_flutter/models/shake_text_input.dart';
import 'package:shake_flutter/models/shake_theme.dart';
import 'package:shake_flutter/models/shake_title.dart';
import 'package:shake_flutter/shake_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NetworkTester networkTester = DartTester();

  bool? userFeedbackEnabled = false;
  bool? shakeInvokingEnabled = false;
  bool? buttonInvokingEnabled = false;
  bool? screenshotInvokingEnabled = false;
  bool? blackboxEnabled = false;
  bool? activityHistoryEnabled = false;
  bool? consoleLogsEnabled = false;
  bool? screenRecordingEnabled = false;
  bool? sensitiveDataEnabled = false;
  bool? screenshotIncluded = false;
  int? shakingThreshold = 400;

  File? file1;
  File? file2;

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  void _initialize() async {
    final userFeedbackEnabled = await Shake.isUserFeedbackEnabled();
    final shakeInvokingEnabled = await Shake.isInvokeShakeOnShakeDeviceEvent();
    final buttonInvokingEnabled = await Shake.isShowFloatingReportButton();
    final screenshotInvokingEnabled = await Shake.isInvokeShakeOnScreenshot();
    final blackboxEnabled = await Shake.isEnableBlackBox();
    final activityHistoryEnabled = await Shake.isEnableActivityHistory();
    final consoleLogsEnabled = await Shake.isConsoleLogsEnabled();
    final screenRecordingEnabled = await Shake.isAutoVideoRecording();
    final sensitiveDataEnabled = await Shake.isSensitiveDataRedactionEnabled();
    final shakingThreshold = await Shake.getShakingThreshold();
    final screenshotIncluded = await Shake.isScreenshotIncluded();

    setState(() {
      this.userFeedbackEnabled = userFeedbackEnabled;
      this.shakeInvokingEnabled = shakeInvokingEnabled;
      this.buttonInvokingEnabled = buttonInvokingEnabled;
      this.screenshotInvokingEnabled = screenshotInvokingEnabled;
      this.blackboxEnabled = blackboxEnabled;
      this.activityHistoryEnabled = activityHistoryEnabled;
      this.consoleLogsEnabled = consoleLogsEnabled;
      this.screenRecordingEnabled = screenRecordingEnabled;
      this.sensitiveDataEnabled = sensitiveDataEnabled;
      this.shakingThreshold = shakingThreshold;
      this.screenshotIncluded = screenshotIncluded;
    });

    file1 = await Files.createDummyFile('file1.txt');
    file2 = await Files.createDummyFile('file2.txt');
  }

  void _onShowHomePressed() {
    Shake.show(ShakeScreen.home);
  }

  void _onShowNewPressed() {
    Shake.show();
  }

  void _onUserFeedbackToggle(enabled) {
    setState(() {
      userFeedbackEnabled = enabled;
    });
    Shake.setUserFeedbackEnabled(enabled);
  }

  void _onShakeInvokingToggle(enabled) {
    setState(() {
      shakeInvokingEnabled = enabled;
    });
    Shake.setInvokeShakeOnShakeDeviceEvent(enabled);
  }

  void _onButtonInvokingToggle(enabled) {
    setState(() {
      buttonInvokingEnabled = enabled;
    });
    Shake.setShowFloatingReportButton(enabled);
  }

  void _onScreenshotInvokingToggle(enabled) {
    setState(() {
      screenshotInvokingEnabled = enabled;
    });
    Shake.setInvokeShakeOnScreenshot(enabled);
  }

  void _onEnableBlackboxToggle(enabled) {
    setState(() {
      blackboxEnabled = enabled;
    });
    Shake.setEnableBlackBox(enabled);
  }

  void _onEnableActivityHistoryToggle(enabled) {
    setState(() {
      activityHistoryEnabled = enabled;
    });
    Shake.setEnableActivityHistory(enabled);
  }

  void _onConsoleLogsEnabledToggle(enabled) {
    setState(() {
      consoleLogsEnabled = enabled;
    });
    Shake.setConsoleLogsEnabled(enabled);
  }

  void _onScreenRecordingEnabledToggle(enabled) {
    setState(() {
      screenRecordingEnabled = enabled;
    });
    Shake.setAutoVideoRecording(screenRecordingEnabled!);
  }

  void _onSensitiveDataEnabledToggle(enabled) {
    setState(() {
      sensitiveDataEnabled = enabled;
    });
    Shake.setSensitiveDataRedactionEnabled(sensitiveDataEnabled!);
  }

  void _onScreenshotIncluded(enabled) {
    setState(() {
      screenshotIncluded = enabled;
    });
    Shake.setScreenshotIncluded(screenshotIncluded!);
  }

  void _onAttachDataPress() {
    List<ShakeFile> shakeFiles = [];
    shakeFiles.add(ShakeFile.create(file1!.path));
    shakeFiles.add(ShakeFile.create(file2!.path, 'customName'));

    Shake.setShakeReportData(shakeFiles);
  }

  void _onSilentReportPress() {
    List<ShakeFile> shakeFiles = [];
    shakeFiles.add(ShakeFile.create(file1!.path));
    shakeFiles.add(ShakeFile.create(file2!.path, 'customName'));

    ShakeReportConfiguration configuration = ShakeReportConfiguration();
    configuration.activityHistoryData = true;
    configuration.blackBoxData = true;
    configuration.screenshot = true;
    configuration.video = true;
    configuration.showReportSentMessage = true;

    Shake.silentReport(
      configuration: configuration,
      description: 'Description',
      shakeFiles: shakeFiles,
    );
  }

  void _addCustomLog() {
    Shake.log(LogLevel.info, 'Custom log.');
  }

  void _addMetadata() {
    Shake.setMetadata("Shake", "Metadata to clear.");
    Shake.clearMetadata();
    Shake.setMetadata('Shake', 'This is a Shake metadata.');
  }

  void _setCustomForm() async {
    // ShakeForm? oldForm = await Shake.getShakeForm();
    // oldForm?.components.removeWhere((element) => element.type == 'inspect');

    List<ShakePickerItem> pickerItems = [
      ShakePickerItem('Mouse', 'Mouse', icon: sampleImage, tag: 'mouse'),
      ShakePickerItem('Keyboard', 'Keyboard',
          icon: sampleImage, tag: 'keyboard'),
      ShakePickerItem('Display', 'Display', tag: 'display')
    ];

    ShakeForm shakeForm = ShakeForm([
      ShakePicker('Category', 'Category', pickerItems),
      ShakeTitle('Short title', 'Short title',
          initialValue: '', required: true),
      ShakeTextInput('Repro Steps', 'Repro Steps',
          initialValue: '', required: false),
      ShakeEmail('YourEmail', 'YourEmail'),
      ShakeInspectButton(),
      ShakeAttachments(),
    ]);

    Shake.setShakeForm(shakeForm);
  }

  void _setCustomTheme() async {
    ShakeTheme shakeTheme = ShakeTheme();
    shakeTheme.fontFamilyBold = 'lib/assets/fonts/Lexend-Bold.ttf';
    shakeTheme.fontFamilyMedium = 'lib/assets/fonts/Lexend-Regular.ttf';
    shakeTheme.backgroundColor = '#FFFFFF';
    shakeTheme.secondaryBackgroundColor = '#FFFFFF';
    shakeTheme.textColor = '#0e0e0e';
    shakeTheme.secondaryTextColor = '#3f3f3f';
    shakeTheme.accentColor = '#ff0000';
    shakeTheme.accentTextColor = '#ffffff';
    shakeTheme.outlineColor = '#464646';
    shakeTheme.borderRadius = 0.0;
    shakeTheme.elevation = 10.0;
    shakeTheme.shadowOffset = Offset(0.1, 0.1);
    shakeTheme.shadowRadius = 3;
    shakeTheme.shadowOpacity = 0.5;

    Shake.setShakeTheme(shakeTheme);
  }

  void _setHomeActions() async {
    List<ShakeBaseAction> homeAction = [
      new ShakeHomeAction(
        "A custom home action",
        () {
          print("Whoopppyy!");
        },
        subtitle: "This is a test subtitle",
        icon: sampleImage,
      ),
      new ShakeSubmitAction(),
      new ShakeChatAction(),
    ];
    Shake.setHomeActions(homeAction);
  }

  void _onShakingThreshold100() {
    Shake.setShakingThreshold(100);
  }

  void _onShakingThreshold600() {
    Shake.setShakingThreshold(600);
  }

  void _onShakingThreshold900() {
    Shake.setShakingThreshold(900);
  }

  void _showNotificationSettings() {
    Shake.showNotificationsSettings();
  }

  void _postNotificationEvent() async {
    FlutterLocalNotificationsPlugin notificationsPlugin =
        FlutterLocalNotificationsPlugin();

    InitializationSettings initializationSettings = InitializationSettings(
        android: AndroidInitializationSettings('@drawable/ic_bug_report'),
        iOS: DarwinInitializationSettings());

    await notificationsPlugin.initialize(initializationSettings);

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails('shake-flutter', 'Shake Flutter');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidDetails);
    await notificationsPlugin.show(
        0,
        'This notification was generated by the app!',
        'Notification message.',
        platformChannelSpecifics);
  }

  void _insertNotificationEvent() {
    NotificationEvent notificationEvent = NotificationEvent()
      ..id = '0'
      ..title = 'Title'
      ..description = 'Description';
    Shake.insertNotificationEvent(notificationEvent);
  }

  void _insertNetworkRequest() {
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

  void _setNotificationEventsFilter() {
    Shake.setNotificationEventsFilter((notificationEvent) {
      notificationEvent.title = "data_redacted";
      notificationEvent.description = "data_redacted";
      return notificationEvent;
    });
  }

  void _setNetworkRequestsFilter() {
    Shake.setNetworkRequestsFilter((networkRequest) {
      networkRequest.requestBody = "data_redacted";
      networkRequest.responseBody = "data_redacted";
      return networkRequest;
    });
  }

  void _onSendGetRequest() async {
    try {
      await networkTester.sendGetRequest();

      Messages.show("Request succeeded.");
    } catch (e) {
      Messages.show(e.toString());
    }
  }

  void _onSendPostRequest() async {
    try {
      await networkTester.sendPostRequest();

      Messages.show("Request succeeded.");
    } catch (e) {
      Messages.show(e.toString());
    }
  }

  void _onGetFileRequest() async {
    try {
      await networkTester.sendGetFileRequest();

      Messages.show("Request succeeded.");
    } catch (e) {
      Messages.show(e.toString());
    }
  }

  void _onSendMultipartFileRequest() async {
    try {
      await networkTester.sendMultipartFileRequest();

      Messages.show("Request succeeded.");
    } catch (e) {
      Messages.show(e.toString());
    }
  }

  void _onSend404Request() async {
    try {
      await networkTester.send404Request();

      Messages.show("Request succeeded.");
    } catch (e) {
      Messages.show(e.toString());
    }
  }

  void _onSendTimeoutRequest() async {
    try {
      await networkTester.sendTimeoutRequest();

      Messages.show("Request succeeded.");
    } catch (e) {
      Messages.show(e.toString());
    }
  }

  void _onRegisterUserPressed() {
    Shake.registerUser('john.smith@example.com');
  }

  void _onUpdateUserIdPressed() {
    Shake.updateUserId('will.smith@example.com');
  }

  void _onUpdateUserMetadataPressed() {
    Shake.updateUserMetadata({'fist_name': 'John', 'last_name': 'Smith'});
  }

  void _onUnregisterUserPressed() {
    Shake.unregisterUser();
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
                        Button('Show Home', _onShowHomePressed),
                        Button('Show New', _onShowNewPressed),
                        Button('Attach data', _onAttachDataPress),
                        Button('Silent report', _onSilentReportPress),
                        Button('Custom log', _addCustomLog),
                        Button('Add metadata', _addMetadata),
                        Button('Set custom form', _setCustomForm),
                        Button('Set custom theme', _setCustomTheme),
                        Button('Set custom actions', _setHomeActions),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header('Invoking'),
                        Toggle('Shaking', shakeInvokingEnabled!,
                            _onShakeInvokingToggle),
                        Toggle('Button', buttonInvokingEnabled!,
                            _onButtonInvokingToggle),
                        Toggle('Screenshot', screenshotInvokingEnabled!,
                            _onScreenshotInvokingToggle),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header('Options'),
                        Toggle('User feedback', userFeedbackEnabled!,
                            _onUserFeedbackToggle),
                        Toggle('Blackbox', blackboxEnabled!,
                            _onEnableBlackboxToggle),
                        Toggle('Activity history', activityHistoryEnabled!,
                            _onEnableActivityHistoryToggle),
                        Toggle('Console logs', consoleLogsEnabled!,
                            _onConsoleLogsEnabledToggle),
                        Toggle('Screen recording', screenRecordingEnabled!,
                            _onScreenRecordingEnabledToggle),
                        Toggle(
                            'Sensitive data redaction',
                            sensitiveDataEnabled!,
                            _onSensitiveDataEnabledToggle),
                        Toggle('Screenshot included', screenshotIncluded!,
                            _onScreenshotIncluded)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header('Shaking threshold'),
                        Button('100 ', _onShakingThreshold100),
                        Button('600', _onShakingThreshold600),
                        Button('900', _onShakingThreshold900),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header('User'),
                        Button('Register user', _onRegisterUserPressed),
                        Button('Update user id', _onUpdateUserIdPressed),
                        Button('Update user metadata',
                            _onUpdateUserMetadataPressed),
                        Button('Unregister user', _onUnregisterUserPressed),
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
                        Button('Send GET request', _onSendGetRequest),
                        Button('Send POST request', _onSendPostRequest),
                        Button('Send GET file request', _onGetFileRequest),
                        Button('Send POST file request',
                            _onSendMultipartFileRequest),
                        Button('Send 404 request', _onSend404Request),
                        Button('Send timeout request', _onSendTimeoutRequest),
                        Button('Insert network request', _insertNetworkRequest),
                        Button('Set network requests filter',
                            _setNetworkRequestsFilter),
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
}
