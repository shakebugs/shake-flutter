import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shake_example/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Link extends StatelessWidget {
  final String text;
  final String link;

  Link(
    this.text,
    this.link,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        width: double.infinity,
        child: GestureDetector(
          onTap: () {
            launch(link);
          },
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ThemeColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
