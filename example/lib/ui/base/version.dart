import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class Version extends StatefulWidget {
  Version();

  @override
  _VersionState createState() => _VersionState();
}

class _VersionState extends State<Version> {
  String version = "";

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        width: double.infinity,
        child: Text(
          "v" + version,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  _loadVersion() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      version = info.version;
    });
  }
}
