import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shake/models/shake_file.dart';
import 'package:shake/models/shake_report_configuration.dart';
import 'package:shake/shake.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await Shake.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              FlatButton(
                onPressed: () {
                  List<ShakeFile> shakeFiles = List();
                  shakeFiles.add(ShakeFile.create("data/image1.jpg"));
                  shakeFiles.add(ShakeFile.create("data/image2.jpg"));

                  ShakeReportConfiguration configuration =
                      ShakeReportConfiguration();

                  Shake.silentReport(
                      "Description", shakeFiles, "Qucik facts", configuration);
                },
                child: Text("Start"),
              )
            ],
          )),
    );
  }
}
