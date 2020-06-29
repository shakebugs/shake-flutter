import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shake/models/shake_file.dart';
import 'package:shake/models/shake_report_configuration.dart';
import 'package:shake/shake.dart';
import 'package:shake_example/constants/colors.dart';
import 'package:shake_example/ui/base/button.dart';
import 'package:shake_example/ui/base/header.dart';
import 'package:shake_example/ui/base/link.dart';
import 'package:shake_example/ui/base/logo.dart';
import 'package:shake_example/ui/base/toggle.dart';
import 'package:shake_example/ui/base/version.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool shakeInvokingEnabled = false;
  bool buttonInvokingEnabled = false;
  bool screenshotInvokingEnabled = false;
  bool shakeEnabled = false;
  bool blackboxEnabled = false;
  bool networkTrackerEnabled = false;
  bool activityHistoryEnabled = false;
  bool inspectScreenEnabled = false;

  @override
  void initState() {
    super.initState();


  }

  _initialize() async {
    shakeInvokingEnabled = await Shake.isInvokeShakeOnShaking();
    buttonInvokingEnabled = await Shake.isShowFloatingReportButton();
    screenshotInvokingEnabled = await Shake.isInvokeShakeOnScreenshot();
    blackboxEnabled = await Shake.isEnableBlackBox();
    activityHistoryEnabled = await Shake.isEnableActivityHistory();
    inspectScreenEnabled = await Shake.isEnableInspectScreen();
    networkTrackerEnabled = false; // Network tracker not implemented yet
    shakeEnabled = true; // Not provided by native SDK
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
                          'Start',
                          _onStartPress,
                        ),
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
                          'Network tracker',
                          networkTrackerEnabled,
                          _onEnableNetworkTrackerToggle,
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
                          'Send network request',
                          _onSendNetworkRequestPress,
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

  _onStartPress() {
    Shake.start();
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
    Shake.setInvokeShakeOnShaking(enabled);
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

  _onEnableNetworkTrackerToggle(enabled) {
    setState(() {
      networkTrackerEnabled = enabled;
    });
    Shake.setEnableInspectScreen(enabled);
  }

  _onAttachDataPress() {
    List<ShakeFile> shakeFiles = List();
    shakeFiles.add(ShakeFile.create("data/image1.jpg"));
    shakeFiles.add(ShakeFile.create("data/image2.jpg"));

    Shake.setShakeReportData(shakeFiles, "Quick facts");
  }

  _onSilentReportPress() {
    List<ShakeFile> shakeFiles = List();
    shakeFiles.add(ShakeFile.create("data/image1.jpg"));
    shakeFiles.add(ShakeFile.create("data/image2.jpg"));

    ShakeReportConfiguration configuration = ShakeReportConfiguration();

    Shake.silentReport("Description", shakeFiles, "Quick facts", configuration);
  }

  _onSendNetworkRequestPress() {}
}
