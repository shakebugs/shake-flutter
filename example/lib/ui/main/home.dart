import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import 'package:shake_flutter/models/shake_file.dart';
import 'package:shake_flutter/models/shake_report_configuration.dart';
import 'package:shake_flutter/shake_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NetworkTester networkTester = DartTester();

  bool shakeInvokingEnabled = false;
  bool buttonInvokingEnabled = false;
  bool screenshotInvokingEnabled = false;
  bool shakeEnabled = false;
  bool blackboxEnabled = false;
  bool activityHistoryEnabled = false;
  bool inspectScreenEnabled = false;

  File file1;
  File file2;

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  _initialize() async {
    final shakeInvokingEnabled = await Shake.isInvokeShakeOnShakeDeviceEvent();
    final buttonInvokingEnabled = await Shake.isShowFloatingReportButton();
    final screenshotInvokingEnabled = await Shake.isInvokeShakeOnScreenshot();
    final blackboxEnabled = await Shake.isEnableBlackBox();
    final activityHistoryEnabled = await Shake.isEnableActivityHistory();
    final inspectScreenEnabled = await Shake.isEnableInspectScreen();
    final shakeEnabled = true; // Not provided by native SDK

    setState(() {
      this.shakeInvokingEnabled = shakeInvokingEnabled;
      this.buttonInvokingEnabled = buttonInvokingEnabled;
      this.screenshotInvokingEnabled = screenshotInvokingEnabled;
      this.blackboxEnabled = blackboxEnabled;
      this.activityHistoryEnabled = activityHistoryEnabled;
      this.inspectScreenEnabled = inspectScreenEnabled;
      this.shakeEnabled = shakeEnabled;
    });

    file1 = await Files.createDummyFile("file1.txt");
    file2 = await Files.createDummyFile("file2.txt");
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
                          shakeInvokingEnabled,
                          _onShakeInvokingToggle,
                        ),
                        Toggle(
                          'Button',
                          buttonInvokingEnabled,
                          _onButtonInvokingToggle,
                        ),
                        Toggle(
                          'Screenshot',
                          screenshotInvokingEnabled,
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
                          shakeEnabled,
                          _onEnableShakeToggle,
                        ),
                        Toggle(
                          'Blackbox',
                          blackboxEnabled,
                          _onEnableBlackboxToggle,
                        ),
                        Toggle(
                          'Activity history',
                          activityHistoryEnabled,
                          _onEnableActivityHistoryToggle,
                        ),
                        Toggle(
                          'Inspect screen',
                          inspectScreenEnabled,
                          _onEnableInspectScreenToggle,
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
                          'Send Multipart file request',
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

  _onAttachDataPress() {
    List<ShakeFile> shakeFiles = List();
    shakeFiles.add(ShakeFile.create(file1.path));
    shakeFiles.add(ShakeFile.create(file2.path, "customName"));

    Shake.setShakeReportData(
      quickFacts: "Quick facts",
      shakeFiles: shakeFiles,
    );
  }

  _onSilentReportPress() {
    List<ShakeFile> shakeFiles = List();
    shakeFiles.add(ShakeFile.create(file1.path));
    shakeFiles.add(ShakeFile.create(file2.path, "customName"));

    ShakeReportConfiguration configuration = ShakeReportConfiguration();
    configuration.activityHistoryData = false;
    configuration.blackBoxData = false;
    configuration.screenshot = false;
    configuration.showReportSentMessage = true;

    Shake.silentReport(
      configuration,
      description: "Description",
      quickFacts: "Quick facts",
      shakeFiles: shakeFiles,
    );
  }

  _onSendGetRequest() async {
    try {
      await networkTester.sendGetRequest();

      Messages.show("Request succeeded.");
    } catch (e) {
      print(e);
      Messages.show(e.toString());
    }
  }

  _onSendPostRequest() async {
    try {
      await networkTester.sendPostRequest();

      Messages.show("Request succeeded.");
    } catch (e) {
      print(e);
      Messages.show(e.toString());
    }
  }

  _onGetFileRequest() async {
    try {
      await networkTester.sendGetFileRequest();

      Messages.show("Request succeeded.");
    } catch (e) {
      print(e);
      Messages.show(e.toString());
    }
  }

  _onSendMultipartFileRequest() async {
    try {
      await networkTester.sendMultipartFileRequest();

      Messages.show("Request succeeded.");
    } catch (e) {
      print(e);
      Messages.show(e.toString());
    }
  }

  _onSend404Request() async {
    try {
      await networkTester.send404Request();

      Messages.show("Request succeeded.");
    } catch (e) {
      print(e);
      Messages.show(e.toString());
    }
  }

  _onSendTimeoutRequest() async {
    try {
      await networkTester.sendTimeoutRequest();

      Messages.show("Request succeeded.");
    } catch (e) {
      print(e);
      Messages.show(e.toString());
    }
  }
}
